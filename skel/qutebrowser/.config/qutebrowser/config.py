config.load_autoconfig (True)



c.fonts.default_family				=		['IBM Plex Mono']
c.downloads.location.directory		=		'~'
c.content.pdfjs						=		False



config.bind (			'wb'		,	'open -- http://web.archive.org/web/{url:pretty}'												)
config.bind (			'xx'		,	'config-cycle statusbar.show always never;; config-cycle tabs.show always never'				)
config.bind (			'yiu'		,	'open -t -- https://yandex.com/images/search?rpt=imageview&url={url:pretty}'					)
config.bind (			';D'		,	'hint images download'																			)
config.bind (	'<Ctrl+Shift+d>'	,	'scroll-page 0 -0.5'																			)
config.bind (		'<Ctrl+o>'		,	'set-cmd-text :open /'																			)
config.bind (	'<Ctrl+Shift+o>'	,	'set-cmd-text :open -t /'																		)
config.bind (			',m'		,	'hint links spawn mpv --fullscreen --ytdl-format="bestvideo+bestaudio/best" {hint-url}'			)
config.bind (			',p'		,	'spawn mpv --fullscreen --ytdl-format="bestvideo+bestaudio/best" {url:pretty}'					)



config.bind (
	',sd',
	'config-cycle content.user_stylesheets solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""'
)

config.bind (
	',sl',
	'config-cycle content.user_stylesheets solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""'
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
	'https://xn--69aa8bzb.xn--y9a3aq'		,		# թութ.հայ
] :
	config.set ('content.notifications.enabled', True, site)

config.set (
	'content.register_protocol_handler'				,
	True											,
	'https://mail.protonmail.com#mailto=%25s'		,
)

config.set (
	'content.headers.user_agent'									,
	'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML,'
		'like Gecko) Chrome/103.0.5060.53 Mobile Safari/537.36'		,
	'*://www.udrop.com/*'
)



c.input.insert_mode.auto_enter						=		True
c.input.insert_mode.auto_leave						=		False
c.statusbar.show									=		'always'
c.tabs.show											=		'always'



c.url.start_pages		=		['about:blank']
# c.url.start_pages		=		['https://regexcrossword.com/']
c.url.default_page		=		'https://duckduckgo.com/'

c.url.searchengines	 = {
	# 'DEFAULT'			:		'https://searx.org/?q={}'										,
	'DEFAULT'			:		'https://duckduckgo.com/?q={}'									,
	'/'					:		'https://duckduckgo.com/?q={}'									,
	'/ai'				:		'https://www.appimagehub.com/find?search={}'					,
	'/aur'				:		'https://aur.archlinux.org/packages/?O=0&K={}'					,
	'/ba'				:		'https://bararanonline.com/{}'									,
	'/duck'				:		'https://duckduckgo.com/?q={}'									,
	'/fh'				:		'https://flathub.org/apps/search/{}'							,
	'/gen'				:		'https://libgen.is/search.php?req={}'							,
	'/gi'				:		'https://github.com/search?q={}'								,
	'/gp'				:		'https://github.com/{}'											,
	'/gr'				:		'https://greasyfork.org/en/scripts?q={}'						,
	'/imdb'				:		'https://www.imdb.com/find?q={}'								,
	'/ly'				:		'https://genius.com/search?q={}'								,
	'/man'				:		'https://man.openbsd.org/?query={}'								,
	'/meet'				:		'https://meet.jit.si/{}'										,
	'/mov'				:		'https://rezka.ag/search/?do=search&subaction=search&q={}'		,
	'/pacman'			:		'https://archlinux.org/packages/?q={}'							,
	'/pdf'				:		'https://www.pdfdrive.com/search?q={}'							,
	'/pip'				:		'https://pypi.org/search/?q={}'									,
	'/r'				:		'https://www.reddit.com/r/{}'									,
	'/solve'			:		'https://www.symbolab.com/solver/step-by-step/{}'				,
	'/st'				:		'https://userstyles.org/styles/browse?search_terms={}'			,
	'/su'				:		'https://{}.suckless.org/'										,
	'/sug'				:		'https://git.suckless.org/{}/log.html'							,
	'/svg'				:		'https://www.svgrepo.com/vectors/{}/'							,
	'/sx'				:		'https://paulgo.io/search?q={}'									,
	'/tp'				:		'https://thepiratebay.org/search.php?q={}'						,
	'/ub'				:		'https://www.urbandictionary.com/define.php?term={}'			,
	'/us'				:		'https://userstyles.world/search?q={}'							,
	'/va'				:		'https://vimawesome.com/?q={}'									,
	'/wa'				:		'https://wiki.archlinux.org/?search={}'							,
	'/wb'				:		'https://web.archive.org/web/{}'								,
	'/wg'				:		'https://wiki.gentoo.org/?search={}'							,
	'/wiki'				:		'https://en.wikipedia.org/w/index.php?search={}'				,
	'/wp'				:		'https://wallhaven.cc/search?q={}'								,
	'/x'				:		'https://1337x.to/search/{}/1/'									,
	'/yi'				:		'https://yandex.com/images/search?text={}'						,
	'/yiu'				:		'https://yandex.com/images/search?rpt=imageview&url={}'			,
	'/yt'				:		'https://yewtu.be/search?q={}'									,
}



# config.source ("gruvbox.py")
# config.source ("selenized.py")

c.colors.webpage.darkmode.enabled = True



# for site in ['https://*suckless.org/*', 'https://*openbsd.org/*', 'https://yewtu.be/*', 'https://tmpout.sh/*', 'https://shapeshed.com/*' ] :
#     config.set (
#         'content.user_stylesheets'																				,
#         '~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css'		,
#         site
#     )
# config.set (
#     'content.user_stylesheets'																				,
#     '~/.config/qutebrowser/searx-solarized.user.css'		,
#     'https://searx.org/'
# )



import os
themefile = os.getenv ('HOME') + '/.local/share/themes/theme-qutebrowser.py'

if os.path.exists (themefile) :
	config.source (themefile)
else :
	import dracula.draw

	dracula.draw.blood (c, {
		'spacing' : {
			'vertical'			:		6		,
			'horizontal'		:		8		,
		}
	})

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
