// ==UserScript==
// @name         regexcrossword without bs
// @version      1.0
// @description  regexcrossword without bs
// @match        *://regexcrossword.com/*
// @grant        none
// @run-at       document-end
// ==/UserScript==

(function () {
	'use strict';

	var elems = document.querySelectorAll(".anim-snow");

	[].forEach.call(elems, function(el) {
		el.classList.remove("anim-snow");
	});
})();
