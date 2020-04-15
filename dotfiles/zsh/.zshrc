#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#
#
###############################

# ohmyzsh
#export ZSH=$HOME/.oh-my-zsh
#plugins=(extract)
#DISABLE_AUTO_TITLE="true"
#source $ZSH/oh-my-zsh.sh

# powerlevel9k
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status user dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
#source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

setopt interactive_comments

setopt COMPLETE_ALIASES

autoload -Uz compinit bashcompinit colors edit-command-line
compinit
bashcompinit
[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*
colors
zle -N edit-command-line
bindkey '^e' edit-command-line

PROMPT="%{$fg[red]%}[%{$fg[blue]%}%n %{$fg[yellow]%}%1~%{$fg[red]%}]%}%{$fg[white]%}$ %{$reset_color%}"
unset HISTFILE

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' rehash true

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

source /usr/share/doc/pkgfile/command-not-found.zsh

ttyctl -f

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



if [[ -x `which dircolors` ]]; then
    if [[ -f ~/.dir_colors ]]; then
        eval $(dircolors -b ~/.dir_colors)
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

export GREP_COLOR=31

# man colors
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[4;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# command modifications
alias cc="gcc -std=c18 -pedantic-errors -Werror=pedantic -Wall -Wextra"
#alias cc=tcc
alias astyle="astyle --style=allman --indent=tab --attach-extern-c --attach-closing-while --indent-switches --indent-after-parens --indent-preproc-block --min-conditional-indent=0 --break-blocks --pad-oper --pad-comma --pad-first-paren-out --align-pointer=middle --align-reference=type --remove-braces --keep-one-line-blocks --keep-one-line-statements --close-templates"
alias df="df -Th -x tmpfs -x devtmpfs"
alias dd="dd status=progress"
alias rm="rm -I"
alias vim="nvim"
alias tree="tree -fNpugshFviC"
alias htop="htop -t"
alias mkdir="mkdir -p"
alias ls="ls -X --color=auto --classify --group-directories-first --human-readable"
#alias ls="lsd -hF"
alias feh="feh --no-fehbg"
alias mc="mc -S yadt256"
alias lynx="lynx -display_charset=UTF-8"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias diff="diff --color=auto"
alias hexdump="hexdump -x -c"
alias cmatrix="cmatrix -b -C red"

# utility
alias _="sudo"
alias ..="cd .."
alias ccat="pygmentize -g"
alias svim="sudo nvim"
alias c="echo -ne '\033c'"
alias wiki="wiki-search-html"
alias cplusplus.com="cppman --source=cplusplus.com && cppman"
alias cppreference.com="cppman --source=cppreference.com && cppman"
alias xib="xsel -ib"
alias xob="xsel -b"
alias xip="xsel -ip"
alias xop="xsel -p"
alias xis="xsel -is"
alias xos="xsel -os"
alias www="python3 -m http.server"
alias srv="www --directory ~/.local/srv"
alias srvcln="wget -r -m -np -nH -R index.html 2> /dev/null"
alias man2pdf="man -Tpdf"
alias myip="curl https://ipecho.net/plain ; echo"
alias off="systemctl poweroff -i"
alias t="trans en:hy"
alias tb="t -brief"
enfix () { trans -brief ru:en "`trans -brief en:ru $@`" }
alias xup="xrdb ~/.Xresources"
alias mkpatch="diff -uraN"
alias wallpaper="feh --no-fehbg --bg-fill"
alias updatemirrors="yes | sudo pacman -Scc && sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syy"
alias vimupdate="vim +PluginUpdate"
iv () { urxvt -e sh -c "imview $1" }
alias suckless="curl https://git.suckless.org/ 2> /dev/null | grep '<a href=\"' | sed 's/^.*<a href=\".*\/log.html\">\(.*\)<\/a><\/td><td>\(.*$\)/\1|\2/' | column -t -s \|"
alias colorscheme="echo -n '\x1b[48;5;0m  \x1b[48;5;1m  \x1b[48;5;2m  \x1b[48;5;3m  \x1b[48;5;4m  \x1b[48;5;5m  \x1b[48;5;6m  \x1b[48;5;7m  \x\n\x1b[48;5;8m  \x1b[48;5;9m  \x1b[48;5;10m  \x1b[48;5;11m  \x1b[48;5;12m  \x1b[48;5;13m  \x1b[48;5;14m  \x1b[48;5;15m  \x1b[0m\n'"
gpush () { git add . ; git commit -m $1 ; git push -u origin master }
alias gpushd="(cd ~/documents/dotfiles; gpush update)"
wttr () { curl "wttr.in/$1?AF" }
chtitle () { printf '\33]2;%s\007' $1 }
alias nfetch="neofetch | lolcat"
alias f="fortune | cowsay | lolcat"

# window title
#chpwd () { chtitle "$USER [$PWD]" }
#chpwd

#https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/extract/extract.plugin.zsh

alias x=extract
extract() {
	local remove_archive
	local success
	local extract_dir

	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: extract [-option] [file ...]
			Options:
			    -r, --remove    Remove archive after unpacking.
		EOF
	fi

	remove_archive=1
	if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
		remove_archive=0
		shift
	fi

	while (( $# > 0 )); do
		if [[ ! -f "$1" ]]; then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi

		success=0
		extract_dir="${1:t:r}"
		case "${1:l}" in
			(*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$1" | tar xv } || tar zxvf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz)
				tar --xz --help &> /dev/null \
				&& tar --xz -xvf "$1" \
				|| xzcat "$1" | tar xvf - ;;
			(*.tar.zma|*.tlz)
				tar --lzma --help &> /dev/null \
				&& tar --lzma -xvf "$1" \
				|| lzcat "$1" | tar xvf - ;;
			(*.tar.zst|*.tzst)
				tar --zstd --help &> /dev/null \
				&& tar --zstd -xvf "$1" \
				|| zstdcat "$1" | tar xvf - ;;
			(*.tar) tar xvf "$1" ;;
			(*.tar.lz) (( $+commands[lzip] )) && tar xvf "$1" ;;
			(*.tar.lz4) lz4 -c -d "$1" | tar xvf - ;;
			(*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$1" ;;
			(*.gz) (( $+commands[pigz] )) && pigz -dk "$1" || gunzip -k "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lrz) (( $+commands[lrunzip] )) && lrunzip "$1" ;;
			(*.lz4) lz4 -d "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.z) uncompress "$1" ;;
			(*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$1" -d $extract_dir ;;
			(*.rar) unrar x -ad "$1" ;;
			(*.rpm) mkdir "$extract_dir" && cd "$extract_dir" && rpm2cpio "../$1" | cpio --quiet -id && cd .. ;;
			(*.7z) 7za x "$1" ;;
			(*.deb)
				mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
				cd "$extract_dir"; ar vx "../${1}" > /dev/null
				cd control; tar xzvf ../control.tar.gz
				cd ../data; extract ../data.tar.*
				cd ..; rm *.tar.* debian-binary
				cd ..
			;;
			(*.zst) unzstd "$1" ;;
			(*)
				echo "extract: '$1' cannot be extracted" >&2
				success=1
			;;
		esac

		(( success = $success > 0 ? $success : $? ))
		(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
		shift
	done
}

# [[ $TERM =~ dvtm* ]] || dvtm
