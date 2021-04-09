 " command! Format execute 'lua vim.lsp.buf.formatting()'
 " function! s:on_lsp_buffer_enabled() abort
 "     setlocal omnifunc=lsp#complete
 "     setlocal signcolumn=yes
 "     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
 "     nmap <buffer> gd <plug>(lsp-definition)
 "     nmap <buffer> gs <plug>(lsp-document-symbol-search)
 "     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
 "     nmap <buffer> gr <plug>(lsp-references)
 "     nmap <buffer> gi <plug>(lsp-implementation)
 "     nmap <buffer> gt <plug>(lsp-type-definition)
 "     nmap <buffer> <leader>rn <plug>(lsp-rename)
 "     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
 "     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
 "     nmap <buffer> K <plug>(lsp-hover)
 "     inoremap <buffer> <expr><c-f> lsp#scroll(+4)
 "     inoremap <buffer> <expr><c-d> lsp#scroll(-4)
 "     " :LspCodeAction TODO and diagnostic

 "     let g:lsp_format_sync_timeout = 1000
 "     autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

 "     " refer to doc to add more commands
 " endfunction

 " augroup lsp_install
 "     au!
 "     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
 "     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
 " augroup END

 " " autocomplite
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']

