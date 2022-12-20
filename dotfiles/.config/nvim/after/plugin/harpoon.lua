local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>aa", mark.add_file)
vim.keymap.set("n", "<leader>ac", mark.clear_all)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<C-j>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<C-k>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<C-l>", function()
	ui.nav_file(4)
end)
-- remove riles
vim.keymap.set("n", "<leader>arh", function()
	ui.rm_file(1)
end)
vim.keymap.set("n", "<leader>arj", function()
	ui.rm_file(2)
end)
vim.keymap.set("n", "<leader>ark", function()
	ui.rm_file(3)
end)
vim.keymap.set("n", "<leader>arl", function()
	ui.rm_file(4)
end)

-- nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
-- nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
-- nnoremap <leader>tw :lua require("harpoon.term").gotoTerminal(3)<CR>

vim.keymap.set("n", "<leader>tu", function()
	term.gotoTerminal(1)
end)
vim.keymap.set("n", "<leader>te", function()
	term.gotoTerminal(2)
end)
vim.keymap.set("n", "<leader>tw", function()
	term.gotoTerminal(3)
end)

-- nnoremap <leader>arh :lua require("harpoon.mark").rm_file(1)<CR>
-- nnoremap <leader>arj :lua require("harpoon.mark").rm_file(2)<CR>
-- nnoremap <leader>ark :lua require("harpoon.mark").rm_file(3)<CR>
-- nnoremap <leader>arl :lua require("harpoon.mark").rm_file(4)<CR>
-- " TODO review if is necessary
-- nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
-- nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
-- nnoremap <leader>tw :lua require("harpoon.term").gotoTerminal(3)<CR>
--nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
-- nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>

-- nnoremap <leader>ash :lua require("harpoon.mark").rm_file(1)<CR>
-- nnoremap <leader>asj :lua require("harpoon.mark").rm_file(2)<CR>
-- nnoremap <leader>ask :lua require("harpoon.mark").rm_file(3)<CR>
-- nnoremap <leader>asl :lua require("harpoon.mark").rm_file(4)<CR>
