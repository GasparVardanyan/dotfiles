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
