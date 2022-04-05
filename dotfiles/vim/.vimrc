" Vundle {{{
set nocompatible		" be iMproved, required
filetype off			" required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'chrisbra/Colorizer'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'frazrepo/vim-rainbow'
" Plugin 'lilydjwg/colorizer'
" Plugin 'powerline/powerline'
" Plugin 'vifm/vifm.vim'
" Plugin 'vim-airline/vim-airline'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'FredKSchott/CoVim'

Plugin 'baskerville/vim-sxhkdrc'
Plugin 'jceb/vim-orgmode'
" Plugin 'makerj/vim-pdf'
" Plugin 'plasticboy/vim-markdown'
" Plugin 'vim-scripts/c.vim'
" Plugin 'vimwiki/vimwiki'

Plugin 'vim-syntastic/syntastic'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'xavierd/clang_complete'
" Plugin 'ycm-core/YouCompleteMe'

Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'
Plugin 'romainl/flattened'

" Plugin 'bluz71/vim-moonfly-colors'
" Plugin 'dracula/vim', { 'name': 'dracula' }
" Plugin 'jnurmine/Zenburn'
" Plugin 'morhetz/gruvbox'
" Plugin 'tomasiser/vim-code-dark'

call vundle#end()
" }}}



" file type and syntax highliting on {{{
filetype plugin indent on
syntax on
" }}}



" vim foldings {{{
autocmd FileType vim setlocal foldmethod=marker | norm zM
" }}}



" specific settings {{{
set colorcolumn=80
set cursorline
set foldlevel=99
set foldmethod=indent
set laststatus=0
" set mouse=a
set noexpandtab
set nu rnu
set shiftwidth=4
set splitbelow
set splitright
set tabstop=4
" set t_Co=256
" set termguicolors
set updatetime=250
let g:python_recommended_style = 0
" }}}



" colorscheme {{{
set background=dark

let themefile = '~/.local/share/themes/theme.vim'

if filereadable (expand (themefile))
	execute 'source' themefile
else
	color solarized
endif

" set background=dark
" set termguicolors
" let g:solarized_extra_hi_groups=1
" colorscheme solarized8

call togglebg#map("<F5>")
" }}}



" gcrypt {{{
command -range=% Encrypt execute "'<,'>!gcrypt -S -e \"$(pass pdata)\" | base64"
command -range=% Decrypt execute "'<,'>!base64 -d | gcrypt -S -d \"$(pass pdata)\""
" }}}



" gitgutter {{{
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)
" }}}



" rainbow {{{
" let g:rainbow_active = 1
" }}}



" split navigations {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}



" sessions {{{
noremap <F1> :mksession! .vim.session <cr>
noremap <F2> :source .vim.session <cr>
noremap <F3> :! rm .vim.session <cr>
" }}}



" whitespaces {{{
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=cyan guibg=cyan
autocmd InsertLeave * redraw!
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWritePre * :%s/\s\+$//e
" }}}



" make sure Vim returns to the same line when you reopen a file {{{
" thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}



" colorize custom xdefaults and palettes {{{
au BufNewFile,BufRead *.xdefaults,*.palette set syntax=xdefaults
" }}}



" colorize urxvt config file {{{
au BufNewFile,BufRead ~/.urxvt/config set filetype=xdefaults
" }}}



" Diff current buffer and the original file {{{
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" }}}



" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_python = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}



" syntastic {{{
au BufNewFile,BufRead * SyntasticToggleMode
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler = "gcc"
let g:syntastic_c_compiler_options = "-std=c18 -pedantic-errors -Werror=pedantic -Wall -Wextra"
" }}}



" airline {{{
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline_powerline_fonts = 1
"
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
"
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'
"
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
" }}}



" backups {{{
set backup
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
" }}}



" Make those folders automatically if they don't already exist. {{{
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
