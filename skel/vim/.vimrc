" Vundle {{{
set nocompatible		" be iMproved, required
filetype off			" required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Plugin 'Shougo/deol.nvim'

Plugin 'mbbill/undotree'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'dbeniamine/cheat.sh-vim'
" Plugin 'vim-scripts/AnsiEsc.vim'
" Plugin 'm00qek/baleia.nvim'

" Plugin 'WolfgangMehner/awk-support'
" Plugin 'WolfgangMehner/bash-support'
" Plugin 'WolfgangMehner/c-support'
" Plugin 'WolfgangMehner/git-support'
" Plugin 'WolfgangMehner/latex-support'
" Plugin 'WolfgangMehner/lua-support'
" Plugin 'WolfgangMehner/matlab-support'
" Plugin 'WolfgangMehner/perl-support'
" Plugin 'WolfgangMehner/python-support'
" Plugin 'WolfgangMehner/verilog-support'
" Plugin 'WolfgangMehner/vim-support'

" Plugin 'dbeniamine/cheat.sh-vim'

" Plugin 'Yggdroot/indentLine'
Plugin 'chrisbra/Colorizer'

" Plugin 'frazrepo/vim-rainbow'
" Plugin 'lilydjwg/colorizer'
" Plugin 'powerline/powerline'
" Plugin 'vifm/vifm.vim'
" Plugin 'vim-airline/vim-airline'

Plugin 'airblade/vim-gitgutter'
" Plugin 'rhysd/git-messenger.vim'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/fzf.vim'
" Plugin 'airblade/vim-rooter'
Plugin 'airblade/vim-highline'
" Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'editorconfig/editorconfig-vim'
" Plugin 'kshenoy/vim-signature'

" Plugin 'preservim/nerdtree'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'FredKSchott/CoVim'

" Plugin 'jdonaldson/vaxe'
Plugin 'baskerville/vim-sxhkdrc'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'
" Plugin 'makerj/vim-pdf'
Plugin 'plasticboy/vim-markdown'
" Plugin 'peterhoeg/vim-qml'
" Plugin 'vim-scripts/c.vim'
" Plugin 'vimwiki/vimwiki'
" Plugin 'lervag/vimtex'

" Plugin 'vim-syntastic/syntastic'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'xavierd/clang_complete'
" Plugin 'ycm-core/YouCompleteMe'
" Plugin 'jeaye/color_coded'

" Plugin 'altercation/vim-colors-solarized'
" Plugin 'lifepillar/vim-solarized8'
Plugin 'overcache/NeoSolarized'
" Plugin 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }
" Plugin 'Tsuzat/NeoSolarized.nvim'
" Plugin 'romainl/flattened'

" Plugin 'bluz71/vim-moonfly-colors'
" Plugin 'dracula/vim', { 'name': 'dracula' }
" Plugin 'jnurmine/Zenburn'
" Plugin 'morhetz/gruvbox'
" Plugin 'tomasiser/vim-code-dark'

" GODMODE ON !!!
" Plugin 'othree/eregex.vim'
" Plugin 'jacquesg/p5-Neovim-Ext'
" Plugin 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
" let g:eregex_force_case = 1
" nnoremap <leader>/ :call eregex#toggle()<CR>
" noremap <leader>: :perldo<space>

call vundle#end()
" }}}
" file type and syntax highliting on {{{
filetype plugin indent on
syntax on
" }}}
" vim-tmux-navigator {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :<C-U>TmuxNavigateRight<cr>
" nnoremap <silent> <S-C-\|> :<C-U>TmuxNavigatePrevious<cr>
" }}}
" vim foldings {{{
autocmd FileType vim,tmux setlocal foldmethod=marker | norm zM
" }}}
" specific settings {{{
set colorcolumn=81
set exrc
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
set mouse=
set updatetime=250
set wildignore+=*.o,*.out,.git
let g:python_recommended_style = 0

nmap <Leader>hs :nohlsearch<cr>
" }}}
" cursorline {{{
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline
" }}}
" {{{ enable highlighting all the matches only in incsearch mode
" set nohlsearch
" augroup vimrc-incsearch-highlight
"   autocmd!
"   autocmd CmdlineEnter [/\?] :set hlsearch
"   autocmd CmdlineLeave [/\?] :set nohlsearch
" augroup END
" }}}
" Solarized8 {{{
let g:solarized_extra_hi_groups=1
let g:solarized_termtrans=1
" }}}
" NeoSolarized {{{
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1
let g:neosolarized_contrast = "normal"
let g:neosolarized_termBoldAsBright = 0
let g:neosolarized_termtrans = 1
let g:neosolarized_vertSplitBgTrans = 1
let g:neosolarized_visibility = "normal"
" }}}
" colorscheme {{{
set background=dark

let themefile = '~/.local/share/themes/theme.vim'

if filereadable (expand (themefile))
	execute 'source' themefile
else
	" color solarized
	" call togglebg#map("<F5>")

	set background=dark
	set termguicolors
	colorscheme NeoSolarized
	" colorscheme selenized_bw
endif
" }}}
" gcrypt {{{
command -range=% Encrypt execute "'<,'>!gcrypt -S -e \"$(pass show pdata)\" | base64"
command -range=% Decrypt execute "'<,'>!base64 -d | gcrypt -S -d \"$(pass show pdata)\""
" }}}
" {{{ Toggles
noremap <leader>tn :CHADopen<cr>
noremap <leader>tt :TagbarToggle<cr>
noremap <leader>tu :UndotreeToggle<cr>
noremap <leader>tc :ColorToggle<cr>
" }}}
" fzf {{{
let $FZF_DEFAULT_OPTS = '--layout=reverse --color fg:-1,bg:-1,hl:#268bd2,fg+:#eee8d5,bg+:#073642,hl+:#268bd2 --color info:#b58900,prompt:#b58900,pointer:#fdf6e3,marker:#fdf6e3,spinner:#b58900'
let $FZF_DEFAULT_COMMAND = 'fd --type f'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'relative': v:false } }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
noremap <leader>ff :Files<cr>
noremap <leader>fm :RG<cr>
noremap <leader>fb :Buffers<cr>
" noremap <C-B> :Buffers<cr>
" inoremap <C-B> <Esc>:Buffers<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-n': 'tab split' }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" }}}
" gitgutter {{{
nmap <Leader>gd <Plug>(GitGutterPreviewHunk)
" nmap <Leader>gf <Plug>(GitGutterFold) " why doesn't work?
nmap <Leader>gf :GitGutterFold<cr>
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" }}}
" highline {{{
xmap <Leader>hh <Plug>(HighlineToggle)
nmap <Leader>hc <Plug>(HighlineClear)
" }}}
" undotree {{{
let g:undotree_WindowLayout=2
let g:undotree_DiffpanelHeight=8
" let g:undotree_DiffCommand = "delta"

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
" }}}
" rainbow {{{
" let g:rainbow_active = 1
" }}}
" split navigations {{{
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
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
au BufNewFile,BufRead *.xdefaults,*.palette,~/.local/etc/theme* set syntax=xdefaults
" }}}
" bs compatibility {{{
au BufNewFile,BufRead ~/windows/* set ff=dos
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
" au BufNewFile,BufRead * SyntasticToggleMode
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_c_compiler = "gcc"
" let g:syntastic_c_compiler_options = "-std=c18 -pedantic-errors -Werror=pedantic -Wall -Wextra"
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
" utility {{{
function GetM3UHeaderA()
	norm O#EXTINF:,j0f=lvg_"*yk
	" read !mediainfo --Output='General;\%Movie\%' -- "$(xsel -op)".mkv
	read !mediainfo --Output='General;\%Track\%' -- "$(xsel -op)".opus
	norm kJxjj
endfunction
function GetM3UHeaderV()
	norm O#EXTINF:,j0f=lvg_"*yk
	read !mediainfo --Output='General;\%Movie\%' -- "$(xsel -op)".mkv
	" read !mediainfo --Output='General;\%Track\%' -- "$(xsel -op)".opus
	norm kJxjj
endfunction
" }}}
