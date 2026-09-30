local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope: Find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope: Git files" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: Grep prompt" })

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
