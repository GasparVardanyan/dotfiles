// ==UserScript==
// @name          Readability - Solarized Light
// @namespace     http://userstyles.org
// @description	  A "solarized light" theme for http://readability.com
// @author        incrediblygood
// @homepage      https://userstyles.org/styles/92711
// @include       http://readability.com/*
// @include       https://readability.com/*
// @include       http://*.readability.com/*
// @include       https://*.readability.com/*
// @run-at        document-start
// @version       0.20131113094154
// ==/UserScript==
(function() {var css = [
	"*{",
	"		color:#586e75 !important;",
	"	}",
	"	",
	"	body, .tools{",
	"		background:#eee8d5 !important;",
	"	}",
	"	",
	"	.tools{",
	"		border-right-style:none !important;",
	"	}",
	"	",
	"	a{",
	"		color:#2aa198 !important;",
	"	}",
	"	",
	"	a:hover{",
	"		background:#fdf6e3 !important;",
	"	}",
	"	",
	"	a:visited{",
	"		color:#b58900 !important;",
	"	}"
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
