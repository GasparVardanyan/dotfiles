config.load_autoconfig (True)



c.fonts.default_family				=		['monospace']
c.downloads.location.directory		=		'~'
c.content.pdfjs						=		True
# c.content.user_stylesheets			=		'solarized-dark-all-sites.css'



config.bind (		'ab'		,		'set statusbar.show never;; set tabs.show never;; open -t about:blank;; fullscreen --enter'		)
config.bind (		'wb'		,		'open -- http://web.archive.org/web/{url:pretty}'												)
config.bind (		'xx'		,		'config-cycle statusbar.show always never;; config-cycle tabs.show always never'				)
config.bind (		'yiu'		,		'open -t -- https://yandex.com/images/search?rpt=imageview&url={url:pretty}'					)
config.bind (		';D'		,		'hint images download'																			)



config.bind (
	',sd',
	'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""'
)

config.bind (
	',sl',
	'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""'
)



for prop in [
	'content.desktop_capture'				,
	'content.media.audio_video_capture'		,
	'content.media.audio_capture'			,
	'content.media.video_capture'			,
] :
	config.set (prop, True, 'https://meet.jit.si')

for site in [
	'https://app.element.io'				,
	'https://web.skype.com'					,
	'https://web.telegram.org'				,
	'https://xn--69aa8bzb.xn--y9a3aq'		,		# թութ.հայ
] :
	config.set ('content.notifications.enabled', True, site)

config.set (
	'content.register_protocol_handler'				,
	True											,
	'https://mail.protonmail.com#mailto=%25s'		,
)



c.input.insert_mode.auto_enter						=		True
c.input.insert_mode.auto_leave						=		False
c.statusbar.show									=		'always'
c.tabs.show											=		'always'



c.url.start_pages		=		['https://duckduckgo.com/']
c.url.default_page		=		'https://duckduckgo.com/'

c.url.searchengines	 = {
	'DEFAULT'			:		'https://duckduckgo.com/?q={}'									,
	'ai'				:		'https://www.appimagehub.com/find?search={}'					,
	'aur'				:		'https://aur.archlinux.org/packages/?O=0&K={}'					,
	'duck'				:		'https://duckduckgo.com/?q={}'									,
	'fh'				:		'https://flathub.org/apps/search/{}'							,
	'gen'				:		'http://libgen.is/search.php?req={}'							,
	'gi'				:		'https://github.com/search?q={}'								,
	'gp'				:		'https://github.com/{}'											,
	'gr'				:		'https://greasyfork.org/en/scripts?q={}'						,
	'imdb'				:		'https://www.imdb.com/find?q={}'								,
	'ly'				:		'https://genius.com/search?q={}'								,
	'man'				:		'https://man.openbsd.org/?query={}'								,
	'meet'				:		'https://meet.jit.si/{}'										,
	'mov'				:		'https://rezka.ag/search/?do=search&subaction=search&q={}'		,
	'pacman'			:		'https://archlinux.org/packages/?q={}'							,
	'pdf'				:		'https://www.pdfdrive.com/search?q={}'							,
	'r'					:		'https://www.reddit.com/r/{}'									,
	'solve'				:		'https://www.symbolab.com/solver/step-by-step/{}'				,
	'st'				:		'https://userstyles.org/styles/browse?search_terms={}'			,
	'su'				:		'https://{}.suckless.org/'										,
	'ub'				:		'https://www.urbandictionary.com/define.php?term={}'			,
	'us'				:		'https://userstyles.world/search?q={}'							,
	'wa'				:		'https://wiki.archlinux.org/?search={}'							,
	'wb'				:		'http://web.archive.org/web/{}'									,
	'wg'				:		'https://wiki.gentoo.org/?search={}'							,
	'wiki'				:		'https://en.wikipedia.org/w/index.php?search={}'				,
	'wp'				:		'https://wallhaven.cc/search?q={}'								,
	'yi'				:		'https://yandex.com/images/search?text={}'						,
	'yiu'				:		'https://yandex.com/images/search?rpt=imageview&url={}'			,
	'yt'				:		'https://www.youtube.com/results?search_query={}'				,
}



# config.source ("gruvbox.py")
# config.source ("selenized.py")

config.source ("qutebrowser-solarized-dark.config.py")

padding = {
	'top'			:		6		,
	'right'			:		8		,
	'bottom'		:		6		,
	'left'			:		8		,
}

c.statusbar.padding			=		padding
c.tabs.padding				=		padding
c.tabs.indicator.width		=		1
c.tabs.favicons.scale		=		1

# import dracula.draw
#
# dracula.draw.blood (c, {
#     'spacing' : {
#         'vertical'			:		6		,
#         'horizontal'		:		8		,
#     }
# })
