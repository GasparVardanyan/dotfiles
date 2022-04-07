// ==UserScript==
// @name          Mega.nz Dark Theme
// @namespace     http://userstyles.org
// @description	  Please. Stop killing my eyes.
// @author        Hiki Hallow
// @homepage      https://userstyles.org/styles/156240
// @include       http://mega.nz/*
// @include       https://mega.nz/*
// @include       http://*.mega.nz/*
// @include       https://*.mega.nz/*
// @run-at        document-start
// @version       0.20180225183231
// ==/UserScript==
(function() {var css = [
	":root {",
	"	--backgrounds: #050505;",
	"}",
	"",
	"body {",
	"	filter: invert(100%);",
	"}",
	"",
	".download .buttons-block > [class*=\"big-\"],",
	"[class*=\"medium-\"],",
	"[class*=\"small-\"],",
	"[class*=\"*\"] {",
	"	filter: invert(100%);",
	"}",
	"",
	".to-clouddrive,",
	".small-red-cross {",
	"	filter: invert(0%) !important;",
	"}",
	"",
	".download.mid-button.red,",
	".nw-fm-left-icons-panel,",
	".cloud-drive,",
	".nw-fm-left-border,",
	".fm-avatar,",
	".activity-status.top,",
	".tiny-icon.membership-status,",
	".fm-account-avatar .avatar-wrapper img,",
	".plan-info > span,",
	".loading-main-block,",
	".logo,",
	".st-bottom-button.st-twitter-button,",
	".st-bottom-button,",
	".thumb,",
	".viewer-image-bl,",
	".link-button.red,",
	".fm-dialog-overlay,",
	".duplicate-conflict.red-header,",
	".red,",
	"a.red,",
	"a.red:link,",
	"a.red:visited,",
	"a.red:hover,",
	"a.red:active,",
	".dark-overlay {",
	"	filter: invert(100%) !important;",
	"}",
	"",
	"html,",
	".loading-mid-white-block,",
	".loading-percentage,",
	".viewer-image-bl {",
	"	background-color: var(--backgrounds) !important;",
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
