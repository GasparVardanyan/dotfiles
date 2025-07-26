// ==UserScript==
// @name         YTMPV
// @namespace    http://your-namespace/
// @version      1.0
// @description  YTMPV
// @match        *://*.youtube.com/*list=*
// @grant        GM.xmlHttpRequest
// @connect      localhost
// ==/UserScript==


window.addEventListener('load', function() {
	let observer = undefined;
	let done = false;

	function readPlaylist () {
		pl=document.getElementsByTagName ('ytd-playlist-panel-video-renderer');
		console.log ("LLLLL: " + pl.length);

		if (0 == pl.length) {
			return;
		}

		if (false == done) {
			observer.disconnect ();
			done = true;

			l = [];
			for (i of pl) {
				url = i.getElementsByTagName ('a') [0].href.split ('&') [0]
				text = i.getElementsByTagName ('a') [0].innerText.split ("\n")
				title = "";
				if (text.length >= 2) {
					title = text [text.length - 2]
				}
				l.push ("#EXTINF:," + title)
				l.push (url);
			}
			if (true || true == confirm ("copy the mpv command?")) {
				list = l.join ("\n");
				list = document.querySelector ('#header-description > h3:nth-child(1) > yt-formatted-string').innerText + "\n" + list;

				console.log ("XXXXXX: " + list);

				GM.xmlHttpRequest({
					method: "POST",
					url: "http://localhost:8765/",
					headers: {
						"Content-Type": "text/plain"
					},
					data: list,
					onload: function(response) {
						console.log("Server response:", response.responseText);
					},
					onerror: function(err) {
						console.error("Request failed", err);
					}
				});
			}
		}
	}


	observer = new MutationObserver(mutationsList => {
		for(let mutation of mutationsList) {
			if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
				readPlaylist ();
			} else if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
				readPlaylist ();
			}
		}
	});

	readPlaylist ();

	observer.observe(document.documentElement, { childList: true, subtree: true, attributes: true });


}, false);

