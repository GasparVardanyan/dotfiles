// ==UserScript==
// @name          solarized dark linux.die.net
// @namespace     http://userstyles.org
// @description	  <a href="http://ethanschoonover.com/solarized">Solarized</a> dark based style for the manpages in linux.die.net.
// @author        shello
// @homepage      https://userstyles.org/styles/69220
// @include       http://linux.die.net/man/*
// @include       https://linux.die.net/man/*
// @run-at        document-start
// @version       0.20120712185758
// ==/UserScript==
(function() {var css = [
	"/*",
	"    linux.die.net manpages, solarized dark style",
	" */",
	"",
	"body { background: #002b36; color: #839496; }",
	"",
	"h1 { border-bottom-color: #586e75; }",
	"h2 { font-size: 1.4em; margin-bottom: 0.2em; }",
	"",
	"p, dl { font-size: 14px; margin-top: 0.5em; }",
	"dd font[color], p font[color], dt font[color] { color: inherit; }",
	"dt > p { display: inline; }",
	"",
	".code { font-size:14px; padding: 0.5em; background-color: #073642; }",
	"",
	"a { color: #b58900; }",
	"",
	"#menu { left: auto; right: 0; opacity: 0.1; }",
	"#menu:hover { opacity: 1; }",
	"#menu, #menu:hover { -webkit-transition: all 0.2s ease; -moz-transition: all 0.2s ease; -o-transition: all 0.2s ease; transition: all 0.2s ease; }",
	"",
	"#content { font-size: 14px; width: 640px; font-family: monospace; }",
	"#content > p > b:only-child { margin-top: 1em; display: inline-block; font-size: 1.2em; }"
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
