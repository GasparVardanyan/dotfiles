// LICENSE
// =======
// Copyright (c) 2017-2019 Advanced Micro Devices, Inc. All rights reserved.
// -------
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// -------
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
// Software.
// -------
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// FidelityFX Contrast Adaptive Sharpening 1.2 by AMD
// ported to mpv by agyild

// Changelog
// 2022
// - Optimized texture lookups for OpenGL 4.0+, DirectX 10+, and OpenGL ES 3.1+
// - Changed rcp + mul operations to div for better clarity when CAS_GO_SLOWER is set to 1, since the compiler should automatically
// optimize those instructions anyway.
// - Made it directly operate on LUMA plane, since the original shader was operating on LUMA by deriving it from RGB. This should
// cause a major increase in performance, especially on OpenGL 4.0+ renderers (4 texture lookups vs. 16)
// - Removed transparency preservation mechanism since the alpha channel is a separate source plan than LUMA
// - Removed final blending between the original and the sharpened pixels since it was redundant
// 
// 2026-11-17
// - Replaced the hardcoded TRC functions with libplacebo's builtin linearize/delinearize functions
// - Added tunable parameter support
// - SHARPENING is renamed as Sharpness to follow the same convention as the other shaders (i.e., NIS, FSR, SGSR)
// - CAS_GO_SLOWER parameter is renamed as UsePreciseMath as per FidelityFX SDK v1.1.4
// - Replaced per-pixel peak divisions with a precomputed reciprocal multiply and collapsed the 12-tap filter weighting and normalization into dot() products
// - Deduplicated shared center-texel min/max bounds across overlapping neighborhoods and balanced reduction trees for ILP
// - Vectorized the four sub-quadrant calculations (including APrxLoSqrtF4 and APrxLoRcpF4) into vec4 SIMD operations
// - Added //!COMPONENTS 1 to enforce single-channel intermediate FBOs, simplified //!WHEN RPN expressions, and eliminated dead channel writes
// - Simplified bilinear interpolation weights and factored out shared texture coordinate offsets in HOOKED_gather
// - Changed UsePreciseMath default from 0 to 1 for better precision and SFU utilization on modern GPUs

// Notes
// - Per AMD's guidelines only upscales content up to 4x (e.g., 1080p -> 2160p, 720p -> 1440p etc.) and everything else in between,
// that means CAS will scale up to 4x at maximum, and any further scaling will be processed by mpv's scalers

// User variables

//!PARAM Sharpness
//!DESC Adjusts the range the shader adapts to high contrast (0 is not all the way off).  Higher values = more high contrast sharpening.
//!TYPE CONSTANT float
//!MINIMUM 0.0
//!MAXIMUM 1.0
0.0

//!PARAM BetterDiagonals
//!DESC If set to 0, drops certain math and texture lookup operations for better performance. This is only useful on pre-OpenGL 4.0 renderers and there is no need to disable it otherwise.
//!TYPE DEFINE
//!MINIMUM 0
//!MAXIMUM 1
1

//!PARAM UsePreciseMath
//!DESC If set to 1, disables the use of optimized approximate transcendental functions which might slightly increase accuracy in exchange of performance.
//!TYPE DEFINE
//!MINIMUM 0
//!MAXIMUM 1
1

//!HOOK LUMA
//!BIND HOOKED
//!DESC FidelityFX Contrast Adaptive Upsampling and Sharpening (CAS) v1.2 (Linearization pass)
//!WHEN OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * >
//!COMPONENTS 1

vec4 hook() {
	return vec4(linearize(HOOKED_tex(HOOKED_pos)).r, 0.0, 0.0, 1.0);
}

//!HOOK LUMA
//!BIND HOOKED
//!DESC FidelityFX Contrast Adaptive Upsampling and Sharpening (CAS) v1.2 (Upsampling and sharpening pass)
//!WHEN OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * >
//!WIDTH OUTPUT.w OUTPUT.w LUMA.w 2 * < * LUMA.w 2 * OUTPUT.w LUMA.w 2 * > * + OUTPUT.w OUTPUT.w LUMA.w 2 * = * +
//!HEIGHT OUTPUT.h OUTPUT.h LUMA.h 2 * < * LUMA.h 2 * OUTPUT.h LUMA.h 2 * > * + OUTPUT.h OUTPUT.h LUMA.h 2 * = * +
//!COMPONENTS 1

// Shader code

#if (UsePreciseMath == 0)

vec4 APrxLoSqrtF4(vec4 a) {
	return uintBitsToFloat((floatBitsToUint(a) >> 1u) + 0x1fbc4639u);
}

vec4 APrxLoRcpF4(vec4 a) {
	return uintBitsToFloat(0x7ef07ebbu - floatBitsToUint(a));
}

float APrxMedRcpF1(float a) {
	float b = uintBitsToFloat(0x7ef19fffu - floatBitsToUint(a));
	return b * (-b * a + 2.0);
}

#endif

vec4 hook()
{
	// Scaling algorithm adaptively interpolates between nearest 4 results of the non-scaling algorithm.
	//  a b c d
	//  e f g h
	//  i j k l
	//  m n o p
	// Working these 4 results.
	//  +-----+-----+
	//  |     |     |
	//  |  f..|..g  |
	//  |  .  |  .  |
	//  +-----+-----+
	//  |  .  |  .  |
	//  |  j..|..k  |
	//  |     |     |
	//  +-----+-----+

	vec2 pp = HOOKED_pos * HOOKED_size - 0.5;
	vec2 fp = floor(pp);
	pp -= fp;

#if (defined(HOOKED_gather) && (__VERSION__ >= 400 || (GL_ES && __VERSION__ >= 310)))
	vec2 base = (fp - 0.5) * HOOKED_pt;
	vec2 step2 = 2.0 * HOOKED_pt;

	vec4 abef = HOOKED_gather(base, 0);

	float b = abef.z;
	float e = abef.x;
	float f = abef.y;

	vec4 cdgh = HOOKED_gather(base + vec2(step2.x, 0.0), 0);

	float c = cdgh.w;
	float g = cdgh.x;
	float h = cdgh.y;

	vec4 ijmn = HOOKED_gather(base + vec2(0.0, step2.y), 0);

	float i = ijmn.w;
	float j = ijmn.z;
	float n = ijmn.y;

	vec4 klop = HOOKED_gather(base + step2, 0);

	float k = klop.w;
	float l = klop.z;
	float o = klop.x;

	#if (BetterDiagonals == 1)
		float a = abef.w;
		float d = cdgh.z;
		float m = ijmn.x;
		float p = klop.y;
	#endif
#else
	ivec2 sp = ivec2(fp);

	#if (BetterDiagonals == 1)
		float a = texelFetch(HOOKED_raw, sp + ivec2(-1, -1), 0).r * HOOKED_mul;
		float d = texelFetch(HOOKED_raw, sp + ivec2( 2, -1), 0).r * HOOKED_mul;
		float m = texelFetch(HOOKED_raw, sp + ivec2(-1,  2), 0).r * HOOKED_mul;
		float p = texelFetch(HOOKED_raw, sp + ivec2( 2,  2), 0).r * HOOKED_mul;
	#endif

	float b = texelFetch(HOOKED_raw, sp + ivec2( 0, -1), 0).r * HOOKED_mul;
	float e = texelFetch(HOOKED_raw, sp + ivec2(-1,  0), 0).r * HOOKED_mul;
	float f = texelFetch(HOOKED_raw, sp                , 0).r * HOOKED_mul;

	float c = texelFetch(HOOKED_raw, sp + ivec2( 1, -1), 0).r * HOOKED_mul;
	float g = texelFetch(HOOKED_raw, sp + ivec2( 1,  0), 0).r * HOOKED_mul;
	float h = texelFetch(HOOKED_raw, sp + ivec2( 2,  0), 0).r * HOOKED_mul;

	float i = texelFetch(HOOKED_raw, sp + ivec2(-1,  1), 0).r * HOOKED_mul;
	float j = texelFetch(HOOKED_raw, sp + ivec2( 0,  1), 0).r * HOOKED_mul;
	float n = texelFetch(HOOKED_raw, sp + ivec2( 0,  2), 0).r * HOOKED_mul;

	float k = texelFetch(HOOKED_raw, sp + ivec2( 1,  1), 0).r * HOOKED_mul;
	float l = texelFetch(HOOKED_raw, sp + ivec2( 2,  1), 0).r * HOOKED_mul;
	float o = texelFetch(HOOKED_raw, sp + ivec2( 1,  2), 0).r * HOOKED_mul;
#endif

	// Soft min and max across [F, G, J, K] (2.0x bigger when BetterDiagonals == 1).
	// Deduplicate shared horizontal center pairs (f, g) and (j, k) across adjacent neighborhoods.
	vec2 mn_fg_jk = min(vec2(f, j), vec2(g, k));
	vec2 mx_fg_jk = max(vec2(f, j), vec2(g, k));

	vec4 mn = min(min(mn_fg_jk.xxyy, vec4(b, c, f, g)), min(vec4(e, h, i, l), vec4(j, k, n, o)));
	vec4 mx = max(max(mx_fg_jk.xxyy, vec4(b, c, f, g)), max(vec4(e, h, i, l), vec4(j, k, n, o)));
#if (BetterDiagonals == 1)
	mn += min(mn, min(min(vec4(a, b, e, f), vec4(c, d, g, h)), min(vec4(i, j, m, n), vec4(k, l, o, p))));
	mx += max(mx, max(max(vec4(a, b, e, f), vec4(c, d, g, h)), max(vec4(i, j, m, n), vec4(k, l, o, p))));
#endif

	// Smooth minimum distance to signal limit divided by smooth max, shaped with sqrt.
	const float bdval = bool(BetterDiagonals) ? 2.0 : 1.0;
	const float thinB = 0.03125; // 1.0 / 32.0

	// Bilinear weights: one multiply + three subtracts instead of four multiplies.
	float v = pp.x * pp.y;
	float t = pp.x - v;
	float u = pp.y - v;
	float s = 1.0 - pp.x - u;
	vec4 stuv = vec4(s, t, u, v);

#if (UsePreciseMath == 1)
	vec4 amp = sqrt(clamp(min(mn, bdval - mx) / mx, 0.0, 1.0));
	stuv /= thinB + mx - mn;
#else
	vec4 amp = APrxLoSqrtF4(clamp(min(mn, bdval - mx) * APrxLoRcpF4(mx), 0.0, 1.0));
	stuv *= APrxLoRcpF4(thinB + mx - mn);
#endif

	// Filter shape.
	//  0 w 0
	//  w 1 w
	//  0 w 0

	const float invPeak = -1.0 / mix(8.0, 5.0, clamp(Sharpness, 0.0, 1.0));
	vec4 w = amp * invPeak;

	// Final weighting.
	//    b c
	//  e f g h
	//  i j k l
	//    n o
	//  _____  _____  _____  _____
	//         fs        gt
	//
	//  _____  _____  _____  _____
	//  fs      s gt  fs  t     gt
	//         ju        kv
	//  _____  _____  _____  _____
	//         fs        gt
	//  ju      u kv  ju  v     kv
	//  _____  _____  _____  _____
	//
	//         ju        kv
	vec4 q = w * stuv;

	vec2 gj_fk = vec2(g + j, f + k);
	vec4 outer = vec4(b + e, c + h, i + n, l + o) + gj_fk.xyyx;

	// Filter.
	float W = dot(4.0 * q + stuv, vec4(1.0));
	float res = dot(outer, q) + dot(vec4(f, g, j, k), stuv);
#if (UsePreciseMath == 1)
	res /= W;
#else
	res *= APrxMedRcpF1(W);
#endif

	return vec4(delinearize(vec4(res, 0.0, 0.0, 1.0)).r, 0.0, 0.0, 1.0);
}