// ==UserScript==
// @name          Evernote - Solarized
// @namespace     http://userstyles.org
// @description	  Applying Solarized colors (as I always seem to) to Evernote Web. Solarized dark makes up the drawers and the text area is Solarized light. It's not perfect, but I'm working on it.
// @author        David Wynn
// @homepage      https://userstyles.org/styles/182873
// @include       http://evernote.com/*
// @include       https://evernote.com/*
// @include       http://*.evernote.com/*
// @include       https://*.evernote.com/*
// @run-at        document-start
// @version       0.20200427022416
// ==/UserScript==
(function() {var css = [
	":root {",
	"    --main-color: #002b36;",
	"    --editor-color: #fdf6e3;",
	"    --main-color__hover: #073642;",
	"    --border-color: #1f4662;",
	"    --text-on-main-color: #93a1a1;",
	"    --accent-color: #b58900;",
	"  }",
	"  #qa-DRAWER,",
	"  #qa-NAV,",
	"  #qa-NAV_POSITION_BOTTOM,",
	"  #qa-NOTE_DETAIL,",
	"  #qa-NOTES_SIDEBAR,",
	"  #qa-SPACE_TITLE,",
	"  section > div {",
	"    background-color: var(--main-color);",
	"    color: var(--text-on-main-color);",
	"    border-color: var(--border-color);",
	"  }",
	"  #qa-NAV {",
	"    border-right: 1px solid var(--border-color);",
	"  }",
	"  #qa-NAV_POSITION_BOTTOM hr {",
	"    border-color: var(--border-color);",
	"  }",
	"  #qa-ALL_NOTEBOOKS_TABLE {",
	"    background-color: var(--editor-color);",
	"  }",
	"  #qa-COMMON_EDITOR_IFRAME,",
	"  #qa-NOTE_EDITOR,",
	"  #qa-NOTE_EDITOR div,",
	"  #qa-ACTIONS_MODAL {",
	"    background-color: var(--editor-color);",
	"    border-color: var(--border-color);",
	"  }",
	"  [aria-label=\"Note List\"] {",
	"    border-color: var(--border-color);",
	"  }",
	"  [aria-label=\"Note List\"] header {",
	"    background: var(--main-color);",
	"    border-color: var(--border-color);",
	"  }",
	"  #qa-NOTES_HEADER,",
	"  [id$=\"NOTES_SIDEBAR_NOTE_TITLE\"] {",
	"    color: var(--text-on-main-color);",
	"  }",
	"  [id$=\"NOTES_SIDEBAR_NOTE_TITLE\"] {",
	"    color: var(--accent-color);",
	"  }",
	"  [id$=\"NOTES_SIDEBAR_NOTE\"] {",
	"    background: var(--main-color);",
	"    color: var(--text-on-main-color);",
	"    border-color: var(--border-color);",
	"  }",
	"  [id$=\"NOTES_SIDEBAR_NOTE\"]:hover {",
	"    background: var(--main-color__hover);",
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
