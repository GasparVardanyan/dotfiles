if nil then
	vim.o.winborder = 'rounded'
	-- vim.cmd [[
	-- 	set completeopt+=noselect,menuone,preview,fuzzy
	-- ]]

	vim.diagnostic.config({
		virtual_text = true,
		virtual_lines = { current_line = true }
	})

	vim.cmd[[set completeopt=menuone,noinsert,popup,fuzzy]]
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end,
	})

	vim.lsp.config.clangd = {
		cmd = { 'clangd', '--background-index' },
		root_markers = { 'compile_commands.json', 'compile_flags.txt' },
		filetypes = { 'c', 'cpp' },
	}

	vim.lsp.enable({'clangd'})

	do return end
end

require ("modular.user.gaspar")
