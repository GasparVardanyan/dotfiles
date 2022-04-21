// ==UserScript==
// @name          Lainchan Solarized
// @namespace     http://userstyles.org
// @description	  A solarized version of lainchan, made to fit my theme.
// @author        bitcat
// @homepage      https://userstyles.org/styles/119402
// @include       http://lainchan.org/*
// @include       https://lainchan.org/*
// @include       http://*.lainchan.org/*
// @include       https://*.lainchan.org/*
// @run-at        document-start
// @version       0.20151012023051
// ==/UserScript==
(function() {var css = [
	"@namespace url(http://www.w3.org/1999/xhtml);",
	"html,",
	"body {",
	"    color: #eee8d5 !important;",
	"    background-color: #002b36 !important;",
	"    padding-bottom: 36px !important;",
	"}",
	"h2 {",
	"    color: #eee8d5 !important;",
	"}",
	".blotter,",
	"#style-select,",
	"img[alt=\"mascot\"],",
	"img[alt=\"header\"] {",
	"    display: none !important;",
	"}",
	"hr,",
	"footer {",
	"    display: none !important;",
	"}",
	".bar {",
	"    border: none !important;",
	"    background-color: #073642 !important;",
	"    box-shadow: 0 0 40px #073642;",
	"    min-height: 28px !important;",
	"}",
	"div.post.reply {",
	"    border: none !important;",
	"    border-radius: 0px !important;",
	"    background-color: #073642 !important;",
	"}",
	".boardlist,",
	"form table tr th {",
	"    background-color: #073642 !important;",
	"}",
	"form table tr th {",
	"    border: none !important;",
	"    border-radius: 0px !important;",
	"}",
	"input[type=\"submit\"],",
	"#password,",
	"input[type=\"text\"],",
	"textarea,",
	"select {",
	"    background-color: #073642 !important;",
	"    border: none !important;",
	"}",
	"input[type=\"text\"]:focus,",
	"textarea:focus {",
	"    border: 1px solid #FFF !important;",
	"    border-radius: 0px !important;",
	"}",
	"img.banner,",
	"img.board_image {",
	"    border: none !important;",
	"}",
	"h1 {",
	"    font-family: \"Open sans\";",
	"    letter-spacing: 0px;",
	"}",
	".prettyprint {",
	"    background: #073642 none repeat scroll 0% 0%;",
	"    font-family: \"Open Sans\", Monaco, Consolas, monospace;",
	"}",
	".pages {",
	"    text-align: center !important;",
	"}",
	".selected {",
	"    font-weight: inherit !important;",
	"    text-decoration: underline !important;",
	"}",
	".ban h2 {",
	"    background-color: #002b36 !important;",
	"}",
	".box.left,",
	".box.right {",
	"    background: #002b36 !important;",
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
