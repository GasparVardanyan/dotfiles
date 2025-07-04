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
	pl=document.getElementsByTagName ('ytd-playlist-panel-video-renderer');
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
		list = document.title + "\n" + list;

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
}, false);

