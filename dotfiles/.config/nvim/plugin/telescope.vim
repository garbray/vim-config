nnoremap <leader>ps :lua require('telescope.builtin').live_grep()<CR>
" search for any string under your cursor
nnoremap <leader>pg :lua require('telescope.builtin').grep_string()<CR>
" nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>lg :lua require('telescope.builtin').live_grep()<CR>

" inoremap <leader>sc <C-O>:set spell!<cr>
noremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) <CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vq :Telescope quickfix<CR>

nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gc :lua require("git-worktree").create_worktree(vim.fn.input("local branch - name > "), vim.fn.input("remote branch - name > "))<CR>
nnoremap <leader>gb :lua require('telescope.builtin').git_branches()<CR>
