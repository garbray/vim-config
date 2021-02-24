"let g:coc_global_extensions = [
"      \'coc-snippets',
"      \'coc-pairs',
"      \'coc-tsserver',
"      \'coc-eslint',
"      \'coc-prettier',
"      \'coc-json',
"      \]

"" GoTo code navigation
"nmap <leader>gd <Plug>(coc-definition)
"nmap <leader>gy <Plug>(coc-type-definition)
"nmap <leader>gi <Plug>(coc-implementation)
"nmap <leader>gr <Plug>(coc-references)
"nmap <leader>rr <Plug>(coc-rename)
"nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
"nmap <leader>g[ <Plug>(coc-diagnostic-prev)
"nmap <leader>g] <Plug>(coc-diagnostic-next)
"nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
"nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
"nnoremap <leader>cr :CocRestart

"function! s:cocActionsOpenFromSelected(type) abort
"  execute 'CocCommand actions.open ' . a:type
"endfunction

"" xmap <silent> <leader>a :<C-u>execute 'CocCommand action.open ' . visualmode()<CR>
"" nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
"" nmap <leader>aw  <Plug>(coc-fix-current)
"" nnoremap <leader>aw :CocAction

"" " Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

""use tab for trigger completion with characters ahead and navigate
"inoremap <silent><expr> <TAB>
"            \ pumvisible() ? "\<C-n>" :
"            \ <SID>check_back_space() ? "\<TAB>" :
"            \ coc#refresh()

""imap <C-l> <Plug>(coc-snippets-expand)
"let g:coc_snippet_next = '<tab>'

"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"" use space to trigger completion
"inoremap <silent><expr> <C-space> coc#refresh()

"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction
""""""""""" PRETTIER CONFIG """"""""""""""""""""

"" prettier command for coc
"command! -nargs=0 Prettier :CocCommand prettier.formatFile <bar> :CocCommand eslint.executeAutofix <CR>
"" run prettier on save
"vmap <leader>f <Plug>(coc-format-selected)
"nmap <leader>f <Plug>(coc-format-selected)
