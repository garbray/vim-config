vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>ga", ":Git fetch --all<CR>")
vim.keymap.set("n", "<leader>grum", ":Git rebase upstream/master<CR>")
vim.keymap.set("n", "<leader>grom", ":Git rebase origin/master<CR>")


vim.keymap.set("n", "<leader>gj", ":diffget //3<CR>")
vim.keymap.set("n", "<leader>gf", ":diffget //2<CR>")

