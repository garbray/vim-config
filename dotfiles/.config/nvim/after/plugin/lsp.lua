local ok_lsp, lspconfig = pcall(require, "lspconfig")
if not ok_lsp then
	return
end

local ok_blink, blink = pcall(require, "blink.cmp")
if not ok_blink then
	return
end

local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason then
	return
end

-- c# server
require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local keymap = vim.keymap.set
local capabilities = blink.get_lsp_capabilities()

local on_attach = function(client, bufnr)
	keymap("n", "<leader>gd", buf.definition, { buffer = bufnr, desc = "Go to definition" })
	keymap("n", "<leader>gr", buf.references, { buffer = bufnr, desc = "Go to references" })
	keymap("n", "K", function()
		buf.hover()
	end, { buffer = bufnr, desc = "Hover documentation" })
	keymap("n", "<leader>vws", buf.workspace_symbol, { buffer = bufnr, desc = "Workspace symbol" })
	keymap("n", "<leader>vd", diagnostic.open_float, { buffer = bufnr, desc = "Open diagnostics" })
	keymap("n", "<leader>gn", function()
		diagnostic.goto_next({ float = true })
	end, { buffer = bufnr, desc = "Go to next diagnostic" })
	keymap("n", "<leader>gp", function()
		diagnostic.goto_prev({ float = true })
	end, { buffer = bufnr, desc = "Go to previous diagnostic" })
	keymap("n", "<leader>ca", function()
		buf.code_action()
	end, { buffer = bufnr, desc = "Code action" })
	keymap("n", "<leader>vrr", buf.references, { buffer = bufnr, desc = "View references" })
	keymap("n", "<leader>rn", buf.rename, { buffer = bufnr, desc = "Rename" })
	keymap("i", "<C-h>", buf.signature_help, { buffer = bufnr, desc = "Signature help" })
	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

-- vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = on_attach })
--
vim.lsp.config("vtsls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("bashls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("omnisharp", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- vim.lsp.config("roslyn", {
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	settings = {
-- 		["csharp|inlay_hints"] = {
-- 			csharp_enable_inlay_hints_for_implicit_object_creation = true,
-- 			csharp_enable_inlay_hints_for_implicit_variable_types = true,
-- 		},
-- 		["csharp|code_lens"] = {
-- 			dotnet_enable_references_code_lens = true,
-- 		},
-- 	},
-- })

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"vtsls",
	"gopls",
	"clangd",
	-- "roslyn",
	"omnisharp",
})

-- mason_lspconfig.setup_handlers({
-- 	function(server_name)
-- 		lspconfig[server_name].setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 		})
-- 	end,
-- 	["lua_ls"] = function()
-- 		lspconfig.lua_ls.setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = { globals = { "vim" } },
-- 				},
-- 			},
-- 		})
-- 	end,
-- 	["vtsls"] = function()
-- 		lspconfig.vtsls.setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
-- 			settings = {
-- 				typescript = {
-- 					inlayHints = {
-- 						parameterNames = { enabled = "literals" },
-- 						variableTypes = { enabled = true },
-- 						returnTypes = { enabled = true },
-- 					},
-- 				},
-- 				javascript = {
-- 					inlayHints = {
-- 						parameterNames = { enabled = "literals" },
-- 						variableTypes = { enabled = true },
-- 						returnTypes = { enabled = true },
-- 					},
-- 				},
-- 				vtsls = {
-- 					enableMoveToFileCodeAction = true,
-- 					autoUseWorkspaceTsdk = true,
-- 				},
-- 			},
-- 		})
-- 	end,
-- })
