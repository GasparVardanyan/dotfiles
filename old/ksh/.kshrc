#HISTSIZE=0

#if [[ -x `which dircolors` ]]; then
#    if [[ -f ~/.dir_colors ]]; then
#        eval $(dircolors -b ~/.dir_colors)
#    elif  [[ -f /etc/dir_colors ]]; then
#        eval $(dircolors -b /etc/dir_colors)
#    else
#        eval $(dircolors -b)
#    fi
#else
#    LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
#    export LS_COLORS
#fi

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
alias vim="vi"
alias tree="tree -fNpugshFviC"
alias htop="htop -t"
alias mkdir="mkdir -p"
#alias ls="ls -X --color=auto --classify --group-directories-first --human-readable"
##alias ls="lsd -hF"
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
alias www="python3 -m http.server"
alias srv="www --directory ~/.local/srv"
alias srvcln="wget -r -m -np -nH -R index.html 2> /dev/null"
alias man2pdf="man -Tpdf"
alias myip="curl https://ipecho.net/plain ; echo"
alias off="systemctl poweroff -i"
alias t="trans en:hy"
alias tb="t -brief"
alias xup="xrdb ~/.Xresources"
alias mkpatch="diff -uraN"
alias wallpaper="feh --no-fehbg --bg-fill"
alias updatemirrors="yes | sudo pacman -Scc && sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syy"
alias vimupdate="vim +PluginUpdate"
alias suckless="curl https://git.suckless.org/ 2> /dev/null | grep '<a href=\"' | sed 's/^.*<a href=\".*\/log.html\">\(.*\)<\/a><\/td><td>\(.*$\)/\1|\2/' | column -t -s \|"
alias colorscheme="echo -n '\x1b[48;5;0m  \x1b[48;5;1m  \x1b[48;5;2m  \x1b[48;5;3m  \x1b[48;5;4m  \x1b[48;5;5m  \x1b[48;5;6m  \x1b[48;5;7m  \x\n\x1b[48;5;8m  \x1b[48;5;9m  \x1b[48;5;10m  \x1b[48;5;11m  \x1b[48;5;12m  \x1b[48;5;13m  \x1b[48;5;14m  \x1b[48;5;15m  \x1b[0m\n'"
gpush ()
{
	git add . ; git commit -m $1 ; git push -u origin master
}
alias gpushd="(cd ~/documents/dotfiles; gpush update)"
