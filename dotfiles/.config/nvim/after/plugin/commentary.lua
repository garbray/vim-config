local comment = require("Comment.api")

vim.keymap.set("n", "<leader>/", function()
	comment.toggle.linewise.current()
end, { desc = "Toggle comment" })

vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })
