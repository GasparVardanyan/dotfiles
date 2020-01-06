/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111", "\uf111"};
static const unsigned maxTagsDisplay = 9;

/* scratchpad */
static const unsigned scratchpad_mask = 1 << sizeof tags / sizeof * tags;
static const unsigned hidden_tags = ~((1 << maxTagsDisplay) - 1);

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ NULL,       NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const float mfact     = .5f;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
# define DMENU_OPTIONS "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4
static const char *dmenucmd[] = { "dmenu_run", DMENU_OPTIONS, NULL };
static const char *termcmd[]  = { "urxvt", NULL };

# include "movestack.c"

static Key keys[] = {
	/* modifier                     key                        function                            argument */
	{ MODKEY,                       XK_l,                      spawn,                              {.v = (const char * []) {"slock", NULL} } },
	{ MODKEY,                       XK_c,                      spawn,                              {.v = (const char * []) {"clipmenu", "-i", DMENU_OPTIONS, NULL} } },
	{ MODKEY,                       XK_d,                      spawn,                              {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,                 spawn,                              {.v = termcmd } },
	{ MODKEY,                       XK_b,                      togglebar,                          {0} },
	{ MODKEY,                       XK_Tab,                    focusstack,                         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Tab,                    focusstack,                         {.i = -1 } },
	{ MODKEY,                       XK_Left,                   focusstack,                         {.i = -1 } },
	{ MODKEY,                       XK_Right,                  focusstack,                         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,                   movestack,                          {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right,                  movestack,                          {.i = +1 } },
	{ MODKEY,                       XK_Up,                     incnmaster,                         {.i = +1 } },
	{ MODKEY,                       XK_Down,                   incnmaster,                         {.i = -1 } },
	{ MODKEY,                       XK_j,                      setmfact,                           {.f = -.05f} },
	{ MODKEY,                       XK_k,                      setmfact,                           {.f = +.05f} },
	{ MODKEY|ShiftMask,             XK_Return,                 zoom,                               {0} },
	{ MODKEY|ShiftMask,             XK_q,                      killclient,                         {0} },
	{ MODKEY|ShiftMask,             XK_f,                      togglefullscr,                      {0} },
	{ MODKEY,                       XK_t,                      setlayout,                          {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,                      setlayout,                          {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,                      setlayout,                          {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_t,                      setlayout,                          {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,                  setlayout,                          {0} },
	{ MODKEY|ShiftMask,             XK_space,                  togglefloating,                     {0} },
	{ MODKEY,                       XK_comma,                  focusmon,                           {.i = -1 } },
	{ MODKEY,                       XK_period,                 focusmon,                           {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,                  tagmon,                             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                 tagmon,                             {.i = +1 } },
	TAGKEYS(                        XK_1,                                                          0)
	TAGKEYS(                        XK_2,                                                          1)
	TAGKEYS(                        XK_3,                                                          2)
	TAGKEYS(                        XK_4,                                                          3)
	TAGKEYS(                        XK_5,                                                          4)
	TAGKEYS(                        XK_6,                                                          5)
	TAGKEYS(                        XK_7,                                                          6)
	TAGKEYS(                        XK_8,                                                          7)
	TAGKEYS(                        XK_9,                                                          8)
	TAGKEYS(                        XK_F1,                                                         9)
	TAGKEYS(                        XK_F2,                                                         10)
	TAGKEYS(                        XK_F3,                                                         11)
	TAGKEYS(                        XK_F4,                                                         12)
	TAGKEYS(                        XK_F5,                                                         13)
	TAGKEYS(                        XK_F6,                                                         14)
	TAGKEYS(                        XK_F7,                                                         15)
	TAGKEYS(                        XK_F8,                                                         16)
	TAGKEYS(                        XK_F9,                                                         17)
	TAGKEYS(                        XK_F10,                                                        18)
	TAGKEYS(                        XK_F11,                                                        19)
	TAGKEYS(                        XK_F12,                                                        20)
	{ MODKEY,                       XK_0,                      view,                               {.ui = ~(scratchpad_mask | hidden_tags) } },
	{ MODKEY|ShiftMask,             XK_0,                      tag,                                {.ui = ~(scratchpad_mask | hidden_tags) } },
	{ MODKEY|ShiftMask,             XK_e,                      quit,                               {0} },
	{ MODKEY,                       XK_minus,                  scratchpad_show,                    {0} },
	{ MODKEY|ShiftMask,             XK_minus,                  scratchpad_hide,                    {0} },
	{ MODKEY,                       XK_equal,                  scratchpad_remove,                  {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
//	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
//	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
//	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
//	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
//	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
//	{ ClkTagBar,            0,              Button1,        view,           {0} },
//	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
//	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
//	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
