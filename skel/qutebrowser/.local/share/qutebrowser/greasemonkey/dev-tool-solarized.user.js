// ==UserScript==
// @name          Dev Tool - Solarized
// @namespace     http://userstyles.org
// @description	  Solarized color theme (both, Dark and Light) for Developer Tool.
// @author        Yuriy Pitometsu
// @homepage      https://userstyles.org/styles/129534
// @run-at        document-start
// @version       0.20160629031156
// ==/UserScript==
(function() {var css = [
	"/* i really want this to be global */",
	"",
	":root.theme-light {",
	"  --theme-body-background: #fdf6e3 !important;",
	"  --theme-sidebar-background: #eee8d5 !important;",
	"",
	"  --theme-tab-toolbar-background: #eee8d5 !important;",
	"  --theme-toolbar-background: #eee8d5 !important;",
	"  --theme-selection-background: #93a1a1 !important;",
	"",
	"  --theme-body-color: #657b83 !important;",
	"  --theme-body-color-alt: #657b83 !important;",
	"  --theme-content-color1: #657b83 !important;",
	"  --theme-content-color2: #657b83 !important;",
	"  --theme-content-color3: #657b83 !important;",
	"",
	"  --theme-highlight-green: #859900 !important;",
	"  --theme-highlight-blue: #6c71c4 !important;",
	"  --theme-highlight-bluegrey: #cb4b16 !important;",
	"  --theme-highlight-lightorange: #b58900 !important;",
	"  --theme-highlight-orange: #2aa198 !important;",
	"  --theme-highlight-red: #dc322f !important;",
	"  --theme-highlight-pink: #d33682 !important;",
	"}",
	":root.theme-dark {",
	"  --theme-body-background: #002b36 !important;",
	"  --theme-sidebar-background: #073642 !important;",
	"",
	"  --theme-tab-toolbar-background: #073642 !important;",
	"  --theme-toolbar-background: #073642 !important;",
	"  --theme-selection-background: #586e75 !important;",
	"",
	"  --theme-body-color: #657b83 !important;",
	"  --theme-body-color-alt: #657b83 !important;",
	"  --theme-content-color1: #657b83 !important;",
	"  --theme-content-color2: #657b83 !important;",
	"  --theme-content-color3: #657b83 !important;",
	"",
	"  --theme-highlight-green: #859900 !important;",
	"  --theme-highlight-blue: #6c71c4 !important;",
	"  --theme-highlight-bluegrey: #cb4b16 !important;",
	"  --theme-highlight-lightorange: #b58900 !important;",
	"  --theme-highlight-orange: #2aa198 !important;",
	"  --theme-highlight-red: #dc322f !important;",
	"  --theme-highlight-pink: #d33682 !important;",
	"}"
].join("\n");
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node);
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
})();
