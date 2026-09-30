-- Commenting is built in since nvim 0.10 (gc / gcc). These keep <leader>/ working.
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
