require("options")
require("plugins")

vim.cmd [[
	filetype plugin indent on
	syntax on

	au WinLeave * set nocursorline
	au WinEnter * set cursorline
	set cursorline

	command -range=% Encrypt execute "'<,'>!gcrypt -S -e \"$(pass show pdata)\" | base64"
	command -range=% Decrypt execute "'<,'>!base64 -d | gcrypt -S -d \"$(pass show pdata)\""

	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
	highlight ExtraWhitespace ctermbg=cyan guibg=cyan
	autocmd InsertLeave * redraw!
	match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd BufWritePre * :%s/\s\+$//e

	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\     execute 'normal! g`"zvzz' |
			\ endif
	augroup END

	au BufNewFile,BufRead *.xdefaults,*.palette,~/.local/etc/theme*,~/.urxvt/config set syntax=xdefaults

	set backup
	set undodir=~/.config/nvim/tmp/undo//
	set backupdir=~/.config/nvim/tmp/backup//
	set directory=~/.config/nvim/tmp/swap//

	if !isdirectory(expand(&undodir))
		call mkdir(expand(&undodir), "p")
	endif
	if !isdirectory(expand(&backupdir))
		call mkdir(expand(&backupdir), "p")
	endif
	if !isdirectory(expand(&directory))
		call mkdir(expand(&directory), "p")
	endif
]]
