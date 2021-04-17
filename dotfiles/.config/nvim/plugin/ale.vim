"let g:ale_fixers = {
"      \'*': ['remove_trailing_lines', 'trim_whitespace'],
"      \'javascript': ['prettier', 'eslint']
"      \}
"let g:ale_fix_on_save = 1
"let g:ale_completion_enabled = 0
"" let g:ale_completion_autoimport = 1
""
"let g:airline#extensions#ale#enabled = 1
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
