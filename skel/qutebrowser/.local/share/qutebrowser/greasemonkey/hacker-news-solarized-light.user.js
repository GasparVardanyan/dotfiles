// ==UserScript==
// @name          Hacker News: Solarized Light
// @namespace     http://userstyles.org
// @description	  Hacker News in Solarized Light.
// @author        alphapapa
// @homepage      https://userstyles.org/styles/167314
// @include       http://news.ycombinator.com/*
// @include       https://news.ycombinator.com/*
// @include       http://*.news.ycombinator.com/*
// @include       https://*.news.ycombinator.com/*
// @run-at        document-start
// @version       0.20181228193431
// ==/UserScript==
(function() {var css = [
	"* {",
	"  border-color: #839496 !important;",
	"}",
	"a {",
	"  color: #268bd2 !important;",
	"}",
	"a:visited {",
	"  color: #6c71c4 !important;",
	"}",
	"body {",
	"  background-color: #fdf6e3 !important;",
	"  color: #657b83 !important;",
	"}",
	"html {",
	"  background-color: #fdf6e3 !important;",
	"}",
	"input,",
	"textarea {",
	"  background-color: #eee8d5 !important;",
	"  color: #657b83 !important;",
	"}",
	"blockquote,",
	"pre {",
	"  background-color: #eee8d5 !important;",
	"  color: #657b83 !important;",
	"}",
	"table {",
	"  background-color: #fdf6e3 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > table,",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > table {",
	"  background-color: #cb4b16 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) a,",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(1) a {",
	"  color: #000 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > tbody:nth-child(1) > tr:nth-child(2),",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(2) {",
	"  background-color: #fdf6e3 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(2) {",
	"  background-color: #fdf6e3 !important;",
	"}",
	".title a {",
	"  color: #657b83 !important;",
	"}",
	".title a:visited {",
	"  color: #93a1a1 !important;",
	"}",
	"a.storylink {",
	"  color: #586e75 !important;",
	"  font-weight: bold;",
	"}",
	".sitestr {",
	"  color: #268bd2 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(1) {",
	"  background-color: #fdf6e3 !important;",
	"}",
	"#hnmain .comhead {",
	"  color: #586e75 !important;",
	"}",
	"#hnmain .c00 {",
	"  color: #657b83 !important;",
	"}",
	"#hnmain a.hnuser {",
	"  color: #b58900 !important;",
	"}",
	"#hnmain span.age a {",
	"  color: #93a1a1 !important;",
	"}",
	".cdd {",
	"  color: rgba(202,0,0,0.65) !important;",
	"}",
	".comment i {",
	"  color: #6c71c4 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(4) {",
	"  background-color: #fdf6e3 !important;",
	"}",
	"#hnmain > tbody:nth-child(1) > tr:nth-child(4) > td:nth-child(1) > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) {",
	"  background-color: #cb4b16 !important;",
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
