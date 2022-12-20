lua require("garbray")

" Terminal commands
" ueoa is first through fourth finger left hand home row.
" This just means I can crush, with opposite hand, the 4 terminal positions
"
" These functions are stored in harpoon.  A plugn that I am developing
nnoremap <leader>aa :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>ac :lua require("harpoon.mark").clear_all()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>ah :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>aj :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>ak :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>al :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>arh :lua require("harpoon.mark").rm_file(1)<CR>
nnoremap <leader>arj :lua require("harpoon.mark").rm_file(2)<CR>
nnoremap <leader>ark :lua require("harpoon.mark").rm_file(3)<CR>
nnoremap <leader>arl :lua require("harpoon.mark").rm_file(4)<CR>
" TODO review if is necessary
nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>tw :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>


nnoremap <leader>ash :lua require("harpoon.mark").rm_file(1)<CR>
nnoremap <leader>asj :lua require("harpoon.mark").rm_file(2)<CR>
nnoremap <leader>ask :lua require("harpoon.mark").rm_file(3)<CR>
nnoremap <leader>asl :lua require("harpoon.mark").rm_file(4)<CR>
