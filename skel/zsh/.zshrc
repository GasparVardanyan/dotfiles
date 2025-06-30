#!/usr/bin/env zsh

bindkey -v

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
autoload -Uz colors edit-command-line

[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*

setopt complete_aliases
setopt interactive_comments

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

colors
zle -N edit-command-line
bindkey '^e' edit-command-line

[ -f ~/.local/share/themes/theme.fzf ] && source ~/.local/share/themes/theme.fzf
source <(fzf --zsh)



# _gen_fzf_default_opts() {
#   local base03="234"
#   local base02="235"
#   local base01="240"
#   local base00="241"
#   local base0="244"
#   local base1="245"
#   local base2="254"
#   local base3="230"
#   local yellow="136"
#   local orange="166"
#   local red="160"
#   local magenta="125"
#   local violet="61"
#   local blue="33"
#   local cyan="37"
#   local green="64"
#   # Uncomment for truecolor, if your terminal supports it.
#   # local base03="#002b36"
#   # local base02="#073642"
#   # local base01="#586e75"
#   # local base00="#657b83"
#   # local base0="#839496"
#   # local base1="#93a1a1"
#   # local base2="#eee8d5"
#   # local base3="#fdf6e3"
#   # local yellow="#b58900"
#   # local orange="#cb4b16"
#   # local red="#dc322f"
#   # local magenta="#d33682"
#   # local violet="#6c71c4"
#   # local blue="#268bd2"
#   # local cyan="#2aa198"
#   # local green="#859900"
#
#   # Comment and uncomment below for the light theme.
#
#   # Solarized Dark color scheme for fzf
#   export FZF_DEFAULT_OPTS="
#     --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
#     --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
#   "
#   ## Solarized Light color scheme for fzf
#   #export FZF_DEFAULT_OPTS="
#   #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
#   #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
#   #"
# }
# _gen_fzf_default_opts


# export PROMPT_OSC="$(printf "\033]133;A\007")"
# PROMPT_OSC="%{\033]133;A\007%}"

PROMPT_OSC=$'%{\e]133;A\a%}'
# PROMPT="${PROMPT_OSC}%n@%m:%~%# "

# PROMPT="%{$fg[red]%}[%{$fg[blue]%}%n %{$fg[yellow]%}%1~%{$fg[red]%}]%}%{$fg[white]%}$ %{$reset_color%}"
#PROMPT="%{$fg[magenta]%}%n%{$fg[yellow]%} -> %{$fg[red]%}[ %{$fg[blue]%}%1~%{$fg[red]%} ]%}%{$fg[yellow]%} :: %{$reset_color%}"
# if [ "$TERM" = st-256color ]
# then
	PROMPT="${PROMPT_OSC}%{$fg[yellow]%}-> %{$fg[red]%}[ %{$fg[blue]%}%1~%{$fg[red]%} ]%}%{$fg[yellow]%} :: %{$reset_color%}"
	# PROMPT="%{$fg[yellow]%}-> %{$fg[red]%}[ %{$fg[blue]%}%1~%{$fg[red]%} ]%}%{$fg[yellow]%} :: %{$reset_color%}"
	# PROMPT="${PROMPT_OSC}%{$fg[red]%}[ %{$fg[blue]%}%1~%{$fg[red]%} ]%}%{$fg[yellow]%} %{$fg[blue]%}  %{$reset_color%}"
# else
# 	PROMPT="%{$fg[red]%}[ %{$fg[blue]%}%1~%{$fg[red]%} ]%}%{$fg[yellow]%} %{$fg[blue]%}  %{$reset_color%}"
# fi
#PROMPT="$(xrdb -query | grep -P '^zsh\*prompt:' | sed 's/^zsh\*prompt:\s//')"
unset HISTFILE
HISTSIZE=2000

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

bindkey '^R' history-incremental-search-backward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# source /usr/share/doc/pkgfile/command-not-found.zsh

ttyctl -f

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh.d/bash.command-not-found
source ~/.zsh.d/zsh-fzf-history-search.zsh
fpath=(~/.zsh.d/ $fpath)



if [[ -x $(which dircolors) ]]; then
	if [[ -f ~/.local/etc/dir_colors ]]; then
		eval $(dircolors -b ~/.local/etc/dir_colors)
	elif  [[ -f /etc/dir_colors ]]; then
		eval $(dircolors -b /etc/dir_colors)
	else
		eval $(dircolors -b)
	fi
else
	LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
	export LS_COLORS
fi
export ZLS_COLORS=$LS_COLORS

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# export GREP_COLOR=31



alias L="lazygit"
# alias grep="rg --engine=pcre2"
# alias sed="perl -pe"
# alias grep="grep -E"
alias grep="pcre2grep --color=auto"
alias sed="sed -E"
alias pe="perl -e 'while (<stdin>) { eval join (\";\", @ARGV); }'"



# command modifications
alias astyle="astyle --style=allman --indent=tab --attach-extern-c --attach-closing-while --indent-switches --indent-after-parens --indent-preproc-block --min-conditional-indent=0 --break-blocks --pad-oper --pad-comma --pad-first-paren-out --align-pointer=middle --align-reference=type --remove-braces --keep-one-line-blocks --keep-one-line-statements --close-templates"
alias cat="bat"
alias cc="gcc -std=c18 -pedantic-errors -Werror=pedantic -Wall -Wextra"
#alias cc=tcc
alias cmatrix="cmatrix -b -C red"
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias dd="dd status=progress"
alias df="df -Th -x tmpfs -x devtmpfs"
# alias diff="diff --color=auto"
alias diff="delta"
alias dir="dir --color=auto"
# alias egrep="egrep --color=auto"
alias feh="feh --no-fehbg --zoom fill"
# alias fgrep="fgrep --color=auto"
# alias grep="grep --color=auto"
alias hexdump="hexdump -x -c"
alias htop="htop -t"
# alias ls="ls -X --color=auto --classify --group-directories-first --human-readable"
# alias ls="lsd -hFX"
alias ls="exa --icons -F -s type --group-directories-first"
alias lst="ls --sort=time"
alias lss="ls --sort=size"
alias lynx="lynx -display_charset=UTF-8"
alias mc="mc -S yadt256"
alias mkdir="mkdir -p"
alias sxiv="nsxiv"
alias tree="tree -fNpugshFviC"
alias vdir="vdir --color=auto"
alias nvim="NVIM_APPNAME='' nvim"
alias nide="NVIM_APPNAME=nvim-ide \\nvim"
alias lazy="NVIM_APPNAME=nvim-lazy \\nvim"
alias nkick="NVIM_APPNAME=nvim-kickstart \\nvim"
alias vim="nvim"
# alias man="nman"

# utility
alias ccat="pygmentize -g"
alias icat="kitten icat"
alias ..="cd .."
alias -- '-'="cd -"
alias chess="telnet freechess.org"
alias colorscheme="echo -n '\x1b[48;5;0m  \x1b[48;5;1m  \x1b[48;5;2m  \x1b[48;5;3m  \x1b[48;5;4m  \x1b[48;5;5m  \x1b[48;5;6m  \x1b[48;5;7m  \n\x1b[48;5;8m  \x1b[48;5;9m  \x1b[48;5;10m  \x1b[48;5;11m  \x1b[48;5;12m  \x1b[48;5;13m  \x1b[48;5;14m  \x1b[48;5;15m  \x1b[0m\n'"
alias cplusplus.com="cppman --source=cplusplus.com && cppman"
alias cppreference.com="cppman --source=cppreference.com && cppman"
alias f="fortune | cowsay | lolcat"
alias filestream="tail -f -n +0"
alias getfeeds='curl "$(xsel -op)" | sfeed_web | cut -f 1'
alias gfup="git fetch upstream master:upstream"
alias ginit="git init --initial-branch=master"
alias glog="git log --oneline"
gsu() {
	XAUTHKEY=$(xauth list | grep "$(uname -n)" | cut -f 5 -d ' ') su --whitelist-environment DISPLAY,XAUTHKEY $@ # xauth add $DISPLAY . $XAUTHKEY
}
alias gmup="git merge upstream/master master"
alias hsrv="hugo server --noHTTPCache"
alias lv="less -ru~ +g"
alias man2pdf="man -Tpdf"
alias mki="make PREFIX=$HOME/.local install"
alias mkpatch="diff -uraN"
alias pp="ps xf -U $(whoami)"
alias myip="curl https://ipecho.net/plain ; echo"
alias nfetch="neofetch | lolcat"
alias ren="perl-rename"
alias s="sc-im"
alias spaste="curl -F 'sprunge=<-' http://sprunge.us"
alias srvcln="wget -r -m -np -nH -R index.html 2> /dev/null"
alias srv="www --directory ~/.local/srv"
alias suckless="curl https://git.suckless.org/ 2> /dev/null | command grep '<a href=\"' | command sed 's/^.*<a href=\".*\/log.html\">\(.*\)<\/a><\/td><td>\(.*$\)/\1|\2/' | column -t -s \|"
alias _="sudo"
compdef _sudo _
alias __="sudo su"
alias svim="sudo nvim"
alias sysupgrade="yes | sudo pacman -Scc && (echo -e '\033[1;34m::\033[0;1m Look for the best server...\033[0m' ; sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyuu && sudo pacman -Fy && sudo pkgfile -u && command vim +PluginUpdate) && tldr -u"
alias S="syncthing serve --no-browser"
alias tb="t -brief"
alias t="trans en:hy"
alias vimupdate="command vim +PluginUpdate"
alias wallpaper="feh --no-fehbg --bg-fill"
alias wiki="wiki-search-html"
alias www="python3 -m http.server"
alias xib="xsel -ib"
alias xip="xsel -ip"
alias xis="xsel -is"
alias xob="xsel -b"
alias xop="xsel -p"
alias xos="xsel -os"
alias xup="xrdb ~/.Xresources"
alias yta="yt-dlp --add-metadata --embed-thumbnail --convert-thumbnails jpg --ppa 'ThumbnailsConvertor:-q:v 1' -f bestaudio/best -x"
alias yt="yt-dlp --add-metadata --embed-thumbnail --convert-thumbnails jpg --ppa 'ThumbnailsConvertor:-q:v 1' -f 'bestvideo+bestaudio/best'"
alias ytpa="yta --download-archive archive.txt"
alias ytpau="yta --download-archive archive.txt -a urls.txt"
alias ytp="yt --download-archive archive.txt"
alias ytpu="yt --download-archive archive.txt -a urls.txt"

alias ytv="mpv --fullscreen --ytdl-format='bestvideo+bestaudio/best'"
chpwd () { chtitle "$TERMINAL -> $PWD" }
chtitle () { printf '\33]2;%s\007' $1 }
dotdiff () {
	alias grep="grep --color=auto"
	alias sed="sed"

	if [[ $2 == 's' ]]
	then
		(cd $1/.. ; git status ; cd -)
	elif [[ $2 == 'd' ]]
	then
		(cd $1/.. ; git diff ; cd -)
	elif [[ $2 == 'u' ]]
	then
		(cd /desktop/dotfiles; gpush update; cd -)
	elif [[ $2 == 'p' ]]
	then
		p
	elif [[ $2 == '' ]]
	then
			find $1 -type f | \sed "s#$1/\(.[^/]*/\(.*\)\)#cmp -s $1/\1 ~/\2 || echo \1#" | zsh | cat -n
	elif [[ $3 == '' ]]
	then
			find $1 -type f | \sed "s#$1/\(.[^/]*/\(.*\)\)#cmp -s $1/\1 ~/\2 || echo diff -uraN $1/\1 ~/\2 \\\| delta#" | zsh | \sed "$2!d" | zsh
	elif [[ $3 == 'u' ]]
	then
		find $1 -type f | \sed "s#$1/\(.[^/]*/\(.*\)\)#cmp -s $1/\1 ~/\2 || echo cp ~/\2 $1/\1 2\\\\>/dev/null \\\\|\\\\| rm $1/\1#" | zsh | \sed "$2!d" | zsh
	elif [[ $3 == 'r' ]]
	then
		find $1 -type f | \sed "s#$1/\(.[^/]*/\(.*\)\)#cmp -s $1/\1 ~/\2 || echo cp $1/\1 ~/\2#" | zsh | \sed "$2!d" | zsh
	fi

	[[ $2 != '' ]] && (echo '=============================='; dotdiff $1)
}
enfix () { trans -brief ru:en "$(trans -brief en:ru $@)" }
gpush () { git add . ; git commit -m "$@" ; git push }
alias gupdate="gpush update"
alias gbackup="gpush backup"
alias gbugfix="gpush bugfix"
imfixsize () { magick $1 $1 }
m () { mega-$1 ${@:2} }
w1 () { wttr $@ m }
w2 () { wttr2 $@ m }

nt () { nsxiv -e $XEMBED $@ }
mt () { mpv --wid=$XEMBED $@ }
compdef _mpv mt

# window title
chpwd

# echo "$(cat ~/.local/etc/banner)"

[ -f ~/.zshprc ] && source ~/.zshprc
