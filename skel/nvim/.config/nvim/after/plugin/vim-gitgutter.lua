vim.cmd [[
	nmap <Leader>gd <Plug>(GitGutterPreviewHunk)
	" nmap <Leader>gf <Plug>(GitGutterFold) " why doesn't work?
	nmap <Leader>gf :GitGutterFold<cr>
	nmap <Leader>gu <Plug>(GitGutterUndoHunk)
	nmap ]h <Plug>(GitGutterNextHunk)
	nmap [h <Plug>(GitGutterPrevHunk)
]]
