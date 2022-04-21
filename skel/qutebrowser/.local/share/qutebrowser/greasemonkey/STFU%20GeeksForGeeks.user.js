// ==UserScript==
// @name         STFU GeeksForGeeks
// @namespace    https://khang06.github.io/
// @version      1.0
// @description  Stop GeeksForGeeks from opening its stupid login modal
// @author       Khangaroo
// @match        https://www.geeksforgeeks.org/*
// @grant        none
// @run-at       document-start
// @license MIT
// ==/UserScript==

(function() {
    'use strict';

    localStorage.setItem("gfgViewCount", 0);
    localStorage.setItem("guestPageCount", 0);
})();