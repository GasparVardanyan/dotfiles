// ==UserScript==
// @name        Invidious - Audio Mode
// @namespace   r-a-y/invidious/audio
// @description Adds a headphone icon next to all video links
// @match       https://yewtu.be/*
// @author      r-a-y
// @version     0.2
// @license     GPL v3
// ==/UserScript==

var thumbs = document.querySelectorAll( 'img.thumbnail' ),
	type;

// Single video.
if ( window.location.href.indexOf( '/watch?' ) > 0 ) {
	type = 'video';
	titles = document.querySelectorAll( 'div.thumbnail + p' );
// Single playlist.
} else if ( window.location.href.indexOf( '/playlist?' ) > 0 ) {
	type = 'playlist';
	titles = document.querySelectorAll( 'p a:nth-child(2)' );
// Channel.
} else if ( window.location.href.indexOf( '/channel/' ) > 0 ) {
	type = 'channel';
	titles = document.querySelectorAll( 'a + p > a' );
// Everything else.
} else {
	type = 'misc';
	titles = document.querySelectorAll( 'p > a' );
}

// DOM inject.
if ( 0 !== titles.length ) {
	for ( i = 0, len = thumbs.length; i < len; ++i ) {
		icon = document.createElement( "a" );
		icon.setAttribute( "style", "margin-left:8px" );
		icon.setAttribute( "title", "Audio mode" );

		if ( 'playlist' === type ) {
			icon.setAttribute( "href", titles[i].previousElementSibling.href + '&listen=1' );
		} else {
			id = thumbs[i].src;

			if ( id.indexOf( '?' ) > 0 ) {
				id = id.substr( 0, id.indexOf( '?' ) );
			}

			id = id.replace( '/mqdefault.jpg', '' );
			id = id.replace( '/hqdefault.jpg', '' );

			id = id.substr( id.lastIndexOf( '/' ) + 1 );

			icon.setAttribute( "href", '/watch?v=' + id + '&listen=1' );
		}

		icon.innerHTML = '<i class="icon ion-md-headset"></i>';
		titles[i].appendChild( icon, titles[i].firstChild );
	}
}
