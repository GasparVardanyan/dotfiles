// ==UserScript==
// @name          edx Solarized
// @namespace     http://userstyles.org
// @description	  A solarized restyle of edX.org site.
// @author        FranKy Ricci
// @homepage      https://userstyles.org/styles/115106
// @include       http://edx.org/*
// @include       https://edx.org/*
// @include       http://*.edx.org/*
// @include       https://*.edx.org/*
// @run-at        document-start
// @version       0.20150630110219
// ==/UserScript==
(function() {var css = [
	"@namespace url(http://www.w3.org/1999/xhtml);",
	"body {",
	"  background: rgb(238, 232, 213) !important;",
	"  ",
	"  }",
	"",
	"  .div {",
	"    background: rgb(238, 232, 213) !important;",
	"    ",
	"  }",
	"  ",
	"  header,footer {",
	"  background: rgb(238, 232, 213) !important;",
	"    ",
	"  }",
	"  ",
	"  .region-column-wrapper {",
	"    background: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  #course-info-page .content-block{",
	"  background: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  #course-info-page  {",
	"  background: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  #course-info-page .course-header__enroll {",
	"  background: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  .xmodule_display.xmodule_SequenceModule .sequence-nav .sequence-list-wrapper {",
	"  background-image: linear-gradient(to bottom, rgb(238, 232, 213), #F9EEEE);",
	"    background-color: rgb(238, 232, 213)",
	"  }",
	"  ",
	"  ",
	"    ",
	"  header.global.slim{",
	"background: rgb(238, 232, 213) !important;",
	"}",
	"  .course-index div#accordion{",
	"background: rgb(238, 232, 213) !important;",
	"}",
	"  ",
	"  ",
	".container > div{",
	"background: rgb(238, 232, 213) !important;",
	"}",
	"",
	".course-content {",
	"  background: rgb(238, 232, 213) !important;",
	"}",
	"",
	" .course-index div#accordion .chapter {",
	"     background-color: rgb(238, 232, 213) !important;",
	"  }",
	"",
	"  .course-material{",
	"    background: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  .xmodule_display.xmodule_VideoModule div.video{",
	"    background: rgb(238, 232, 213) !important;",
	"  }",
	"  div.info-wrapper section.updates {",
	"  background-color: rgb(238, 232, 213) !important;",
	"  }",
	"  ",
	"  div.info-wrapper section.handouts{",
	"  background-color: rgb(238, 232, 213) !important;",
	"  }",
	".sidebar, .course-index, div#wiki_panel, div.info-wrapper section.handouts, div.book-wrapper section.book-sidebar, .profile-wrapper .user-info {",
	"background-color: rgb(238, 232, 213) !important; ",
	"  }",
	"",
	"  .xmodule_display.xmodule_SequenceModule .sequence-nav ol li a.active  {",
	"background-color: rgb(238, 232, 213) !important;",
	"}",
	"  .content-wrapper {",
	"    background-color: rgb(238, 232, 213) !important;",
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
