-- LSP configuration (no lsp-zero dependency)
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local keymap = vim.keymap.set
-- local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local on_attach = function(client, bufnr)
	-- keymap("n", "gd", buf.definition, { buffer = bufnr, desc = "Go to definition" })
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
	keymap("n", "gr", buf.references, { buffer = bufnr, desc = "Go to references" })
	keymap("n", "K", buf.hover, { buffer = bufnr, desc = "Hover documentation" })
	keymap("n", "<leader>vws", buf.workspace_symbol, { buffer = bufnr, desc = "Workspace symbol" })
	keymap("n", "<leader>vd", diagnostic.open_float, { buffer = bufnr, desc = "Open diagnostics" })
	keymap("n", "<leader>gn", diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
	keymap("n", "<leader>gp", diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })
	keymap("n", "<leader>ca", buf.code_action, { buffer = bufnr, desc = "Code action" })
	keymap("n", "<leader>vrr", buf.references, { buffer = bufnr, desc = "View references" })
	keymap("n", "<leader>rn", buf.rename, { buffer = bufnr, desc = "Rename" })
	keymap("i", "<C-h>", buf.signature_help, { buffer = bufnr, desc = "Signature help" })
end

-- Mason setup
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "rust_analyzer", "tailwindcss", "gopls", "pyright" },
	handlers = {
		function(server_name)
			vim.lsp.config[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
})

-- Server-specific overrides
vim.lsp.config.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.config.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "javascript", "typescript", "vue" },
})

vim.lsp.config.eslint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
