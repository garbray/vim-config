local rest_nvim = require("rest-nvim")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "http",
	callback = function()
		local buff = tonumber(vim.fn.expand("<abuf>"), 10)
		vim.keymap.set("n", "<leader>rn", rest_nvim.run, { noremap = true, buffer = buff })
	end,
})
