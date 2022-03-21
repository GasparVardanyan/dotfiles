// ==UserScript==
// @name          Wikipedia Solarized Material
// @namespace     http://userstyles.org
// @description	  Wikipedia with material-style cards and the Solarized color scheme
// @author        Stephen Gough
// @homepage      https://userstyles.org/styles/142478
// @include       http://wikipedia.org/*
// @include       https://wikipedia.org/*
// @include       http://*.wikipedia.org/*
// @include       https://*.wikipedia.org/*
// @run-at        document-start
// @version       0.20170514051705
// ==/UserScript==
(function() {var css = [
	"/* global font settings */",
	"* {",
	"  font-size: 17px;",
	"  font-weight: 300;",
	"  line-height: 1.7;",
	"  color: #fff!important;",
	"  font-family: sans-serif!important;",
	"}",
	"",
	"/* header bar background color */",
	"#mw-head,",
	"div.vectorTabs,",
	"div.vectorTabs span,",
	"#searchInput {",
	"  background-image: none;",
	"  background-color: #00141a;",
	"}",
	"",
	"/*section header color*/",
	"#mp-tfp-h2,",
	"#mp-tfa-h2,",
	".warningbox,",
	".mw-body h2,",
	".k-player .control-bar,",
	"table.tmbox-protection,",
	"table.wikitable > caption,",
	".suggestions-result-current,",
	".wikiEditor-ui-toolbar .booklet .index .current {",
	"  background: #2aa198!important;",
	"  border: 1px solid #073642!important;",
	"}",
	"",
	"/* body color */",
	"body,",
	"code,",
	"table,",
	".mw-body,",
	"#mp-left,",
	".quotebox,",
	".catlinks,",
	"#mp-right,",
	"#mp-bottom,",
	"div#footer,",
	"#wpTextbox1,",
	".MainPageBG,",
	".boilerplate,",
	".footer-sidebar,",
	"div#simpleSearch,",
	"#searchInput,",
	".lang-list-button,",
	".lang-list-content,",
	".mw-highlight pre,",
	"table.ombox-notice,",
	".vertical-navbox th,",
	".lang-list-button-wrapper,",
	".bookshelf-container .text,",
	".shortcutbox.plainlist.noprint,",
	"body.page-Main_Page #mp-topbanner,",
	"table.toccolours.collapsible.collapsed,",
	".lang-list-active .lang-list-container, .no-js .lang-list-container {",
	"  color: #fff;",
	"  border: 0px!important;",
	"  background: #002b36!important;",
	"}",
	"",
	"/* card color */",
	"#toc,",
	"select,",
	".navbox,",
	".barbox,",
	"#wpSave,",
	"#filetoc,",
	".infobox,",
	".navbox th, ",
	".barbox th,",
	".barbox tr,",
	".barbox td,",
	".navbox th,",
	".wikitable, ",
	".navbox-list,",
	".navbox-title,",
	"div.thumbinner, ",
	" table.toccolours,",
	"td.diff-context,",
	".vertical-navbox,",
	"td.diff-addedline,",
	"table.tmbox-notice,",
	"table.fmbox-system,",
	"input[type=\'file\'],",
	".NavFrame.collapsed,",
	"td.diff-deletedline, ",
	"#mw-history-compare,",
	"table.ambox-content,",
	"input[type=\'reset\'], ",
	"input[type=\'submit\'], ",
	"input[type=\'button\'], ",
	".suggestions-special,",
	".suggestions-results,",
	".wikiEditor-ui-toolbar,",
	"#mw-history-compare li,",
	"#typeahead-suggestions,",
	".oo-ui-popupWidget-popup,",
	"table.tmbox-notice table,",
	"#pagehistory li.selected,",
	"div#editpage-specialchars,",
	"div#editpage-specialchars a, ",
	".fancycaptcha-captcha-container,",
	"html body.mediawiki .mbox-small,",
	".noprint.portal.plainlist.tright,",
	".infobox.standard-talk.bordered th,",
	".wikiEditor-ui .wikiEditor-ui-view,",
	".mw-editform-legacy input#wpSummary,",
	".oo-ui-popupToolGroup .oo-ui-tool-link,",
	".wikiEditor-ui-toolbar .booklet .pages,",
	".wikiEditor-ui-toolbar .sections .section,",
	".wikiEditor-ui-toolbar .group .tool-select,",
	".wikiEditor-ui-toolbar .group .tool-select .label,",
	".wikiEditor-ui-toolbar .group .tool-select .menu .options,",
	".wikiEditor-ui-toolbar .group .tool-select .options .option,",
	".ve-init-mw-desktopArticleTarget-toolbar-opened > .oo-ui-toolbar-bar,",
	".oo-ui-popupToolGroup.oo-ui-widget-enabled > .oo-ui-popupToolGroup-handle {",
	"  background: #073642!important;",
	"  border: 3px solid #073642!important;",
	"}",
	".wikiEditor-ui-toolbar .page-characters div span:hover {",
	"    background: #073642!important;",
	"}",
	"",
	"/* link colors */",
	"a,",
	"#toc h2,",
	"li.selected a:visited,",
	"span.mw-editsection-bracket,",
	"div.vectorTabs li a:visited {",
	"  color: #2aa198!important;",
	"}",
	"a:hover {",
	"  color: #cb4b16!important;",
	"  text-decoration: none;",
	"}",
	"a:visited {",
	"  color: #6c71c4!important;",
	"}",
	"a.external.text {",
	"  color: #859900!important;",
	"}",
	"a.new {",
	"  color: #dc322f;",
	"}",
	".mw-body-content a.extiw {",
	"  color: #268bd2;",
	"}",
	"",
	"/* Table background colors */",
	"td.table-yes {",
	"  background: #2aa198!important;",
	"}",
	"td.table-no {",
	"  background: #dc322f!important;",
	"}",
	"td.unknown.table-unknown,",
	"#wpTextbox1,",
	".sitedir-ltr input {",
	"  background: #0a4c5c!important;",
	"}",
	"td.table-partial {",
	"  background: #268bd2!important;",
	"}",
	"",
	"/* table border color */",
	"td,",
	"tr,",
	"th {",
	"  border-color: #002b36!important;",
	"}",
	"",
	"/*current page underline color*/",
	"div.vectorTabs li.selected {",
	"  border-bottom: 2px solid #fff;",
	"}",
	"",
	"/* misc */",
	"fieldset {",
	"  border-color: #2aa198;",
	"}",
	".navbox-list ul {",
	"  margin: 10px 0px;",
	"  border-top: 1px solid #fff;",
	"}",
	"table.wikitable {",
	"  border: 1px solid #fff!important;",
	"}",
	".mwe-math-fallback-image-inline {",
	"    background: #2aa198;",
	"    border: 3px solid #2aa198!important;",
	"    border-radius: 3px;",
	"}",
	"",
	"/* End colors */",
	"",
	"",
	"/* section header styling */",
	"#mp-tfp-h2,",
	"#mp-tfa-h2,",
	".warningbox,",
	".mw-body h2,",
	"table.tmbox-notice,",
	"table.tmbox-protection {",
	"  margin-top: 50px;",
	"  margin-bottom: 20px;",
	"  padding-left: 10px;",
	"  border-radius: 3px;",
	"	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);",
	"}",
	"",
	"/* card styling */",
	"#toc,",
	".navbox,",
	".barbox,",
	".infobox,",
	".wikitable,",
	"table.cquote,",
	"div.thumbinner, ",
	".vertical-navbox,",
	"table.toccolours,",
	"table.fmbox-system,",
	"table.ambox-content,",
	"#mw-history-compare,",
	"html body.mediawiki .mbox-small,",
	".fancycaptcha-captcha-container,",
	".noprint.portal.plainlist.tright {",
	"  border-radius: 3px;",
	"  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);",
	"	margin: 30px!important;",
	"}",
	"",
	"/*article title*/ ",
	".mw-body .firstHeading {",
	"  position: absolute;",
	"  top: 8px;",
	"  z-index: 1;",
	"  width: 1150px;",
	"  border: 0px;",
	"  max-width: 1122px;",
	"  max-height: 51px;",
	"  overflow: auto;",
	"  font-weight: 100;",
	"  font-size: 35px;",
	"}",
	"",
	"/*article title; special rules for italics*/",
	".mw-body .firstHeading i {",
	"  position: absolute;",
	"  top: -7px;",
	"  z-index: 1;",
	"  width: 1150px;",
	"  border: 0px;",
	"  max-width: 1122px;",
	"  max-height: 51px;",
	"  overflow: auto;",
	"  font-weight: 100;",
	"  font-size: 35px;",
	"}",
	"",
	"/*Header bar styling*/",
	"#mw-head {",
	"  height: 87px;",
	"  box-shadow: 0px 0px 10px 0px #000;",
	"}",
	"",
	"/*hide side panel*/",
	"#mw-panel {",
	"  display: none;",
	"}",
	"",
	"/*paragraph styling*/",
	"p {",
	"  display: block;",
	"  width: 75%;",
	"	margin: auto;",
	"}",
	".mw-body {",
	"  margin: 0px 30px;",
	"  border: 0px;",
	"}",
	"",
	"/*header bar profile links*/",
	"#p-personal li,",
	"#p-personal a {",
	"  line-height: 1;",
	"  margin: 0px 2px;",
	"  font-size: 12px;",
	"}",
	"",
	"/*header navigation links*/",
	"#left-navigation {",
	"  position: absolute;",
	"  margin-left: 1em;",
	"	margin-top: 2.5em;",
	"  float: left;",
	"}",
	"#right-navigation a,",
	"#left-navigation  a {",
	"	margin: 0px 20px;",
	"}",
	"",
	"/*search bar styling*/",
	"div#simpleSearch {",
	"  bottom: 15px;",
	"  height: 40px;",
	"  border: 0px;",
	"}",
	"div#simpleSearch input {",
	"  position: absolute;",
	"  right: -7px;",
	"  width: 100%;",
	"  top: 8px;",
	"}",
	"",
	"/*Info card title styling*/",
	".infobox caption {",
	"  border: 3px;",
	"  border-color: inherit;",
	"  border-top-left-radius: 3px;",
	"  border-top-right-radius: 3px;",
	"  background: inherit; ",
	"  font-weight: 100;",
	"  padding: 10px;",
	"}",
	"",
	"/*card text styling*/",
	".infobox td, ",
	".infobox th, ",
	".infobox tr,",
	".infobox div.NavFrame div.NavHead {",
	"  background: inherit!important;",
	"}",
	"",
	"/*Table of contents header*/",
	"#toc h2,",
	"#toctitle.toctitle,",
	".infobox table.wikitable {",
	"  font-weight: 400;",
	"  background: inherit!important;",
	"  box-shadow: none;",
	"}",
	"",
	"/*section header font size*/",
	".mw-headline,",
	".mw-headline i,",
	".mw-body h2 a,",
	".mw-body h2 i  {",
	"  font-size: 25px!important;",
	"}",
	"",
	"/* Editor styling*/",
	".editOptions {",
	"  border: 0px;",
	"  background: inherit;",
	"}",
	".wikiEditor-ui .wikiEditor-ui-top {",
	"  border: 0px;",
	"}",
	".wikiEditor-ui-toolbar,",
	"div.wikiEditor-ui-clear + div#editpage-specialchars {",
	"    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);",
	"}",
	"",
	"/* media player styling */",
	".k-player .k-options {",
	"  border: 0px!important;",
	"  margin-top: -4px;",
	"}",
	".k-player .k-options span {",
	"    position: relative;",
	"    top: 0px;",
	"}",
	"",
	"",
	"",
	"/*tweaks*/",
	".noprint.navbox.metadata.plainlist,",
	".vertical-navbox.nowraplinks.infobox,",
	".infobox.sisterproject.plainlinks.haudio,",
	".navbox + .navbox,",
	"table.metadata.mbox-small,",
	".nocolbreak, ",
	"div.columns li, ",
	"div.columns dd dd,",
	"p {",
	"  margin-top: 20px!important;",
	"}",
	".noprint.Inline-Template.Template-Fact span,",
	"sup.reference a {",
	"  font-size: 12px;",
	"}",
	"pre,",
	"code,",
	".mw-code {",
	"  background: inherit!important;",
	"  font-family: monospace!important;",
	"}",
	"  ",
	"td,",
	"tr,",
	"th {",
	"  background: inherit!important;",
	"}",
	"img,",
	".navbox-odd,",
	".navbox-odd ul  {",
	"  border: 0px!important;",
	"}",
	"div.thumbcaption,",
	".thumbcaption a,",
	".thumbcaption i,",
	".thumbcaption .nowrap {",
	"  font-size: 14px!important;",
	"}",
	".navbox,",
	"table.fmbox-system {",
	"  width: 80%; ",
	"}",
	".infobox.bordered td, .infobox.bordered th {",
	"	padding: 6px!important;",
	"	padding-left: 9px!important;",
	"}",
	"html .thumbimage,",
	"table.wikitable > tr > th, ",
	"table.wikitable > * > tr > th {",
	"  background: inherit!important;",
	"}",
	".navbox.collapsible.uncollapsed {",
	"  width: 80%; ",
	"}",
	"div#simpleSearch #searchInput {",
	"  width: 304px;",
	"  right: 30px;",
	"}",
	"",
	".thumbcaption table {",
	"  background: inherit;",
	"}",
	"",
	"div#simpleSearch #searchButton {",
	"  display: none;",
	"}",
	"#coordinates {",
	"	top: -15px;",
	"}",
	"#coordinates span,",
	"#coordinates a {",
	"  font-size: 12px!important;",
	"}",
	"small a {",
	"  font-size: 100%;",
	"}",
	".mw-body h2 a {",
	"  color: #fff!important;",
	"}",
	".plainlist ol, .plainlist ul {",
	"  background: inherit!important;",
	"}",
	"",
	"#mw-history-compare li,",
	"#pagehistory li.selected {",
	"  border: 0px!important;",
	"  line-height: 2.5em;",
	"}",
	".infobox tr th div,",
	".infobox div.plainlist,",
	".thumbimage,",
	"#talkheader td,",
	"#talkheader code,",
	".infobox table.infobox ",
	"td.wpbs-inner.outercollapse,",
	".mediawiki .mbox-inside .tmbox,",
	".infobox.collapsible.collapsed,",
	"table.ambox-content table.plainlinks.metadata.ambox {",
	"  background: inherit!important;",
	"  box-shadow: none!important;",
	"  border: 0px!important;",
	"}",
	" #toc,",
	"table {",
	"  padding: 20px!important;",
	"}",
	"h2 span.mw-editsection-bracket {",
	"  font-size: 25px!important;",
	"  margin: 0px!important;",
	"}",
	"",
	"",
	"#footer-info-copyright a {",
	"  font-size: 1em;",
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
