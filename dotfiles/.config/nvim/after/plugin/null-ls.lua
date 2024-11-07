local null_ls_status_ok, null_ls = pcall(require, "null-ls")
-- local cspell = require("cspell")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier,
		-- diagnostics.eslint_d,
		-- .with({
		-- condition = function(utils)
		--     return utils.root_has_file({'package.json', 'tsconfig.json', '.git/'})
		-- end,
		-- extra_args = {},
		-- }),
		-- formatting.prettierd,
		formatting.isort,
		formatting.black.with({ extra_args = { "--fast" } }),
		-- require("null-ls").builtins.formatting.stylua,
		formatting.stylua,
		diagnostics.flake8,
		completion.spell,
		-- diagnostics.eslint,
		diagnostics.codespell,
		diagnostics.misspell,
		-- diagnostics.cspell,
		-- diagnostics.with({
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		diagnostic.severity = vim.diagnostic.severity["HINT"]
		-- 	end,
		-- }),
		-- cspell.diagnostics,
		-- cspell.code_actions,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
