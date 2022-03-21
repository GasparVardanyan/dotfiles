// ==UserScript==
// @name          Minimal Quotev
// @namespace     http://userstyles.org
// @description	  Uses the smallest amount of styles possible to make Quotev readable. Some colors shamefully taken from Solarized (http://ethanschoonover.com/solarized) theme.
// @author        pcenero
// @homepage      https://userstyles.org/styles/110593
// @include       https://www.quotev.com/*
// @run-at        document-start
// @version       0.20150220042435
// ==/UserScript==
(function() {var css = [
	"/* Written by Phoenix Enero. */",
	"/* Enable user-select (because honestly, fuck those people who keep disabling them.) */",
	"* {",
	"  -webkit-user-select: text !important;",
	"  -moz-user-select: text !important;",
	"  -ms-user-select: text !important;",
	"  user-select: text !important;",
	"  cursor: auto !important;",
	"}",
	"",
	"/* Use less ugly fonts. */",
	"#p_cview .story_title {",
	"  font-family: Helvetica, sans-serif;",
	"}",
	"",
	"/* Display selections (fuck you Quotev.) */",
	"::selection {",
	"  background: #38d !important;",
	"  color: #fff;",
	"}",
	"",
	"::-moz-selection {",
	"  background: #38d !important;",
	"  color: #fff;",
	"}",
	"",
	"::-webkit-selection {",
	"  background: #38d !important;",
	"  color: #fff;",
	"}",
	"",
	"/* Lower contrast for much easier readability.",
	" * Colors from Solarized theme.",
	" */",
	"body {",
	"  background-color: #EEE8D5;",
	"  color: #174E5A;",
	"}",
	"",
	"/* Remove ridiculous web 2.0 styles */",
	"a {",
	"  font-weight: normal;",
	"}",
	"",
	"div.story_text {",
	"  font-size: 18px;",
	"  text-align: justify;",
	"  padding: 1em 7em 1em;",
	"  text-rendering: optimizeLegibility;",
	"}",
	"    ",
	".story_text * {",
	"  line-height: 1.75",
	"}",
	"",
	"#mainbar {",
	"  color: #eee;",
	"  background-color: #222 !important;",
	"  box-shadow: none !important;",
	"  border-radius: 0 !important;",
	"  border: 0 !important;",
	"}",
	"",
	"#descr {",
	"  background-color: #FDF6E3 !important;",
	"}",
	"",
	"div.mainbar a, ",
	"div.mainbar a:visited, ",
	"div.mainbar a:link {",
	"  color: #eee;",
	"  font-weight: normal;",
	"}",
	"",
	"#footer_pages {",
	"  font-weight: normal;",
	"  font-variant: normal;",
	"  letter-spacing: 0;",
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
