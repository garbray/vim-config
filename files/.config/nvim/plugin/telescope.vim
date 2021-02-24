lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter, file_ignore_patterns = { "node_modules" }}})

" lua << EOF
" require('telescope').setup({
"     defaults = {
"         file_ignore_patterns = {"node_modules"},
"         file_sorter = require'telescope.sorters'.get_fuzzy_file,
"         grep_previewer = require'telescope.previewers'.vimgrep.new,
"     }
" })
" EOF

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

