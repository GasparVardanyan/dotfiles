// ==UserScript==
// @name          Dark Solarized Lobster
// @namespace     http://userstyles.org
// @description	  A Solarized (Dark) Lobste.rs
// @author        Yann Esposito (yogsototh)
// @homepage      https://userstyles.org/styles/139281
// @include       http://lobste.rs/*
// @include       https://lobste.rs/*
// @include       http://*.lobste.rs/*
// @include       https://*.lobste.rs/*
// @include       http://xn--29ap2a0a1bc.xn--y9aam0eb9a4abc.xn--y9a3aq/*
// @include       https://xn--29ap2a0a1bc.xn--y9aam0eb9a4abc.xn--y9a3aq/*
// @include       http://*.xn--29ap2a0a1bc.xn--y9aam0eb9a4abc.xn--y9a3aq/*
// @include       https://*.xn--29ap2a0a1bc.xn--y9aam0eb9a4abc.xn--y9a3aq/*
// @run-at        document-start
// @version       0.20170222153618
// ==/UserScript==
(function() {var css = [
	"body { background-color: #073642; color: #93a1a1; }",
	"a { color: #b58900; }",
	"#wrapper textarea, #wrapper input, #wrapper button { color: #93a1a1; background-color: #002b36; border-color: #073642; }",
	"#header .headerlinks a.cur_url { color: #2aa198; }",
	"#header #headertitle a { color: #2aa198; }",
	"#header .headerlinks a { color: #839496; }",
	"#inside li .link a { color: #b58900; }",
	"#inside li .byline { color: #839496; }",
	"#inside li .byline a { color: #839496; }",
	"#inside li .domain { color: #839496; }",
	"#inside .comment a { color: #b58900; }",
	"#wrapper div.morelink a { color: #839496; }",
	"#wrapper div#footer a { color: #839496; }",
	"",
	"/* header logo */",
	"#wrapper #header #headerleft #l_holder { background-color: #dc322f !important; }",
	"",
	"/* buttons */",
	"div.voters .upvoter:hover, .upvoted div.voters .upvoter { border-bottom-color: #dc322f ; }",
	"",
	"  ",
	"/* tag badges */",
	"#inside a.tag { background-color: #002b36; border-color: #073642; color: #aaa; }",
	"#inside a.tag.tag_is_media { background-color: #622; border-color: #944; }",
	"#inside a.tag.tag_announce, #inside a.tag.tag_ask, #inside a.tag.tag_show, #inside a.tag.tag_interview { background-color: #226; border-color: #449; }",
	"",
	"/* hats */",
	"#inside span.hat span.crown { background-color: #002b36; border-color: #073642; }",
	"#inside span.hat { border-color: #073642; }",
	"#inside span.hat span.crown, #inside span.hat a { color: #aaa; }",
	"",
	"/* tag dropdown */",
	"#inside .select2-container-multi .select2-choices { background-color: #002b36; border-color: #073642; }",
	"#inside .select2-container .select2-drop { background-color: #002b36; border-color: #073642; }",
	"",
	"/* search pager */",
	"#inside div.page_link_buttons a { color: #839496; background-color: #002b36; border-color: #073642; }",
	"#inside div.page_link_buttons a.cur, #inside div.page_link_buttons span { color: #839496; background-color: #073642; border-color: #073642; }",
	"",
	"/* history/filter table */",
	"#inside table.data th { background-color: #002b36; border-color: #073642; }",
	"#inside table.data tr.row0 td, table.data.zebra tr:nth-child(2n) td { background-color: #073642; border-color: #073642; }",
	"#inside table.data tr.row1 td, table.data.zebra tr:nth-child(2n+1) td { background-color: #002b36; border-color: #073642; }"
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
