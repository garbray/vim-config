-- Linting for filetypes without an LSP linter. Linters are installed by
-- mason-tool-installer (see plugins/lsp.lua).
return {
	{
		"mfussenegger/nvim-lint",
		-- BufReadPre so the BufReadPost autocmd below exists before it fires
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
			}

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("garbray-lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
