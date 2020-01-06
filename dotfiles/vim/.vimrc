" preamble
set nocompatible
filetype off



" plugin management
if has ('vim_starting')
	set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'lilydjwg/colorizer'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'edkolev/tmuxline.vim'			" Theme for tmux
Plugin 'makerj/vim-pdf'
"Plugin 'vim-scripts/Tabmerge'
Plugin 'baskerville/vim-sxhkdrc'
"Plugin 'FredKSchott/CoVim'
Plugin 'davidhalter/jedi-vim'
call vundle#end()



" file type and syntax highliting on
filetype plugin indent on
syntax on



" colorscheme
set background=dark
color leet2



" tabs in visual mode
vmap <Tab> :s/^/\t/ <Bar> nohls <Bar> norm gv <cr>
vmap <S-Tab> :s/^\t\?// <Bar> nohls <Bar> norm gv <cr>



" sessions
noremap <F1> :mksession! .vim.session <cr>
noremap <F2> :source .vim.session <cr>
noremap <F3> :! rm .vim.session <cr>



" specific settings
set tabstop=4
set shiftwidth=4
set nu
set mouse=a
set updatetime=250
set t_Co=256
set splitbelow
set splitright



" whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=cyan guibg=cyan
autocmd InsertLeave * redraw!
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWritePre * :%s/\s\+$//e



" make sure Vim returns to the same line when you reopen a file
" thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END



" cursorline
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline



" colorize i3 config file
"aug i3config_ft_detection
"  au!
"  au BufNewFile,BufRead ~/.i3/config set filetype=i3
"aug end



" colorize urxvt config file
aug urxvt_config_ft_detection
  au!
  au BufNewFile,BufRead ~/.urxvt/config set filetype=xdefaults
aug end



" colorize wm's statusbar script
"aug statusbar_ft_detection
"  au!
"  au BufNewFile,BufRead ~/.local/share/statusbar set filetype=sh
"aug end



" Diff current buffer and the original file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()



" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler = "gcc"
let g:syntastic_c_compiler_options = $MY_GCC_OPTIONS



" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''



" backups
set backup
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//



" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
