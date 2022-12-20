local keymap = vim.keymap.set

keymap("n", "<leader>ca", "<cmd>Lspsaga code_action end<CR>", {})
keymap("n", "<leader>ld", "<cmd>Lspsaga lsp_fincer<CR>", {})
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {})
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
