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
	let oldHref = window.location.href;
	MyPlayLists=[];

	function readPlaylist () {
		pl=document.getElementsByTagName ('ytd-playlist-panel-video-renderer');
		console.log ("LLLLL: " + pl.length);

		if (0 == pl.length) {
			return;
		}

		if (false == done) {
			l = [];
			MyCurrentPlayList = new Set ();
			for (i of pl) {
				url = i.getElementsByTagName ('a') [0].href.split ('&') [0]
				MyCurrentPlayList.add (url);

				text = i.getElementsByTagName ('a') [0].innerText.split ("\n")
				title = "";
				if (text.length >= 2) {
					title = text [text.length - 2]
				}
				l.push ("#EXTINF:," + title)
				l.push (url);
			}
			for (i = 0; i < MyPlayLists.length; i++) {
				diff = MyCurrentPlayList.difference (MyPlayLists [i]);
				console.log (diff);
				dl = diff.size;
				console.log ("dl: " + dl);
				if (dl == 0) {
					console.log ("DDD");
					console.log (MyCurrentPlayList);
					done = true;
					break;
				}
			}
		}

		if (false == done) {
			// observer.disconnect ();
			done = true;
			console.log ("DONE");
			if (true || true == confirm ("copy the mpv command?")) {
				list = l.join ("\n");
				list = document.querySelector ('#header-description > h3:nth-child(1) > yt-formatted-string').innerText + "\n" + list;

				MyPlayLists.push (MyCurrentPlayList);

				// console.log ("XXXXXX: " + list);

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
		newHref = window.location.href;
		if (oldHref != newHref) {
			done = false;
			oldHref = newHref;
			console.log ("RESETTTTT");
		}

		if (false == done) {
			for(let mutation of mutationsList) {
				if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
					readPlaylist ();
				} else if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
					readPlaylist ();
				}
			}
		}
	});

	readPlaylist ();

	observer.observe(document.documentElement, { childList: true, subtree: true, attributes: true });


}, false);

