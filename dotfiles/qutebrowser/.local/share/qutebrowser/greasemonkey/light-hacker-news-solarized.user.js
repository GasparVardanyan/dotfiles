// ==UserScript==
// @name          Light Hacker News - Solarized
// @namespace     http://userstyles.org
// @description	  A "solarized light" theme for hacker news http://news.ycombinator.com
// @author        incrediblygood
// @homepage      https://userstyles.org/styles/92694
// @include       http://news.ycombinator.com/*
// @include       https://news.ycombinator.com/*
// @include       http://*.news.ycombinator.com/*
// @include       https://*.news.ycombinator.com/*
// @run-at        document-start
// @version       0.20151211172718
// ==/UserScript==
(function() {var css = [
	"* {",
	"    color: #586e75 !important;",
	"    background-color: #eee8d5 !important;",
	"  }",
	"  body > center > table > tbody > tr:first-child * {",
	"    background-color: #fdf6e3 !important;",
	"  }",
	"  body > center > table > tbody > tr:first-child * a:hover {",
	"    background: #eee8d5 !important;",
	"  }",
	"  code, pre, input, textarea {",
	"    background: #fdf6e3 !important;",
	"  }",
	"  a {",
	"    color: #2aa198 !important;",
	"  }",
	"  .subtext a {",
	"    color: #586e75 !important;",
	"  }",
	"  a:visited, a:visited span {",
	"    color: #b58900 !important;",
	"  }",
	"  a:hover, a:hover span {",
	"    background: #fdf6e3 !important;",
	"  }"
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
