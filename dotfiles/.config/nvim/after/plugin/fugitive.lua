vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status (fugitive)" })
vim.keymap.set("n", "<leader>ga", ":Git fetch --all<CR>", { desc = "Git fetch --all" })
vim.keymap.set("n", "<leader>grum", ":Git rebase upstream/master<CR>", { desc = "Git rebase upstream/master" })
vim.keymap.set("n", "<leader>grom", ":Git rebase origin/master<CR>", { desc = "Git rebase origin/master" })

-- merge conflict resolution
vim.keymap.set("n", "<leader>gj", ":diffget //3<CR>", { desc = "Diffget from right (theirs)" })
vim.keymap.set("n", "<leader>gf", ":diffget //2<CR>", { desc = "Diffget from left (ours)" })
