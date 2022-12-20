set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" TODO review if makes sense use sagas or not
nnoremap <leader>gD :lua vim.lsp.buf.Declaration()<CR>
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>K :Lspsaga hover_doc<CR>
nnoremap <leader><c-k> :Lspsaga signature_help<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
" nnoremap <leader><c-K> :Lspsaga vim.lsp.buf.signature_help()<CR>
"
" nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ca :Lspsaga code_action<CR>
" nnoremap <leader>ca :lua require('telescope.builtin').lsp_code_actions()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn :Lspsaga rename<CR>
" nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>gn :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>gp :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>vll :call LspLocationList()<CR>
" buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

