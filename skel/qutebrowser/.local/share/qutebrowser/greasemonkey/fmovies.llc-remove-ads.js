// ==UserScript==
// @name         fmovies.llc without ads
// @version      1.0
// @description  fmovies.llc without ads
// @match        *://www.youtube.com/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function () {
// Function to apply pointer cursor to all yellow-background elements
    function removeAds() {
        const ad = document.querySelectorAll('*');
        ad.forEach(element => {
            const zIndex = window.getComputedStyle(element).getPropertyValue('z-index');
            if (zIndex !== '0' && zIndex !== 'auto') {
// Apply your styles here
                element.style.display = 'none'; // Example: hide the element
            }
        });

        // ['#overlay-container'].forEach (sel => {
        //     const ad = document.querySelectorAll(sel);
        //     ad.forEach(element => {
        //         element.style.display = 'none';
        //     });
        // });

// Apply at page startup
        window.addEventListener('load', removeAds);
        removeAds ();

// MutationObserver to watch for changes in the DOM
        const observer = new MutationObserver(mutationsList => {
            for(let mutation of mutationsList) {
                if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
// New elements added to the DOM
                    removeAds();
                } else if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
// Existing element's style changed
                    removeAds();
                }
            }
        });

// Observe changes in the entire document
        observer.observe(document.documentElement, { childList: true, subtree: true, attributes: true });

    })();
