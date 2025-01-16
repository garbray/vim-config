local term = require("simple-term")

vim.keymap.set("n", "<leader>tu", function()
	term.goto_terminal(1)
end)
vim.keymap.set("n", "<leader>te", function()
	term.goto_terminal(2)
end)
