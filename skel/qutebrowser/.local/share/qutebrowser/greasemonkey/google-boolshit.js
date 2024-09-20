// ==UserScript==
// @name         google boolshit fixer
// @version      1.0
// @description  google boolshit fixer
// @match        *://mail.google.com/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function () {setTimeout(function () {
// Function to apply pointer cursor to all yellow-background elements
    function removeAds() {
        const ad = document.querySelectorAll('*');
        ad.forEach(element => {
			if (element.innerHTML == "Missing message notifications?") {
				btns = element.parentElement.getElementsByTagName ("button");
				for (i = 0; i < btns.length; i++)
					if ("Continue" == btns [i].innerHTML) {
						button = btns [i];

						// Simulate a mouse down, up, and click event sequence
						button.dispatchEvent(new MouseEvent('mousedown', { bubbles: true, cancelable: true }));
						button.dispatchEvent(new MouseEvent('mouseup', { bubbles: true, cancelable: true }));
						button.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
						element.parentNode.removeChild(element);
					}
			}
        });
	}

	window.addEventListener('load', removeAds);
	removeAds ();

	const observer = new MutationObserver(mutationsList => {
		for(let mutation of mutationsList) {
			if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
				removeAds();
			} else if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
				removeAds();
			}
		}
	});

	observer.observe(document.documentElement, { childList: true, subtree: true, attributes: true });

}, 5000);})();
