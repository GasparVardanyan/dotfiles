-- options {{{
--require("options")
vim.opt.foldmethod = "marker"
vim.opt.colorcolumn = "81"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.wildignore += "*.o,*.out,.git"
vim.opt.updatetime = 250
vim.g.python_recommended_style = 0
-- }}}
-- plugins {{{
--require("plugins")
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		--{
			--"folke/tokyonight.nvim",
			--lazy = false, -- make sure we load this during startup if it is your main colorscheme
			--priority = 1000, -- make sure to load this before all the other start plugins
			--config = function()
				---- load the colorscheme here
				--vim.cmd([[colorscheme tokyonight]])
			--end,
		--},
		{ "overcache/NeoSolarized", },
		{ 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig", },
		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				vim.cmd([[TSUpdate]])
			end,
		},
		{ "mbbill/undotree", },
		{ "christoomey/vim-tmux-navigator", },
		{ "airblade/vim-gitgutter", },
		{ "scrooloose/nerdcommenter", },
		{ "tpope/vim-fugitive", },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "NeoSolarized" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
-- }}}
--vimscript {{{
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
-- }}}
-- utility {{{
vim.cmd [[
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
]]
-- }}}
