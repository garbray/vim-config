-- contain all the lsp config
local lsp_zero = require("lsp-zero")
local cmp = require("cmp")
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local keymap = vim.keymap.set
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local mason = require("mason")

local lsp_attach = function(client, bufnr)
	keymap("n", "gd", function()
		buf.definition()
	end, { buffer = bufnr, remap = false, desc = "Go to definition" })
	keymap("n", "gr", function()
		buf.references()
	end, { buffer = bufnr, remap = false, desc = "Go to references" })
	keymap("n", "K", function()
		buf.hover()
	end, { buffer = bufnr, remap = false, desc = "Hover documentation" })
	keymap("n", "<leader>vws", function()
		buf.workspace_symbol()
	end, { buffer = bufnr, remap = false, desc = "Workspace symbol" })
	keymap("n", "<leader>vd", function()
		diagnostic.open_float()
	end, { buffer = bufnr, remap = false, desc = "Open diagnostics" })
	keymap("n", "<leader>gn", function()
		diagnostic.goto_next()
	end, { buffer = bufnr, remap = false, desc = "Go to next diagnostic" })
	keymap("n", "<leader>gp", function()
		diagnostic.goto_prev()
	end, { buffer = bufnr, remap = false, desc = "Go to previous diagnostic" })
	keymap("n", "<leader>ca", function()
		buf.code_action()
	end, { buffer = bufnr, remap = false, desc = "Code action" })
	-- keymap("n", "<leader>ca", "<cmd>Lspsaga code_action end<CR>", {})
	keymap("n", "<leader>vrr", function()
		buf.references()
	end, { buffer = bufnr, remap = false, desc = "View references" })
	keymap("n", "<leader>rn", function()
		buf.rename()
	end, { buffer = bufnr, remap = false, desc = "Rename" })
	keymap("i", "<C-h>", function()
		buf.signature_help()
	end, { buffer = bufnr, remap = false, desc = "Signature help" })
end

lsp_zero.extend_lspconfig({
	lsp_attach = lsp_attach,
})

-- install new servers
mason.setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "rust_analyzer", "tailwindcss", "gopls", "pyright" },
	handlers = {
		-- this first function is the "default handler"
		-- it applies to every language server without a "custom handler"
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

local cmp_action = lsp_zero.cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "copilot" },
		{ name = "codeium" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		-- { name = "buffer" },
		-- { name = "path" },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
		-- ["<Tab>"] = cmp.mapping.select_next_item({ behavior = "select" }),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.html.setup({
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end,
})

lspconfig.ts_ls.setup({
	capabilities = lsp_capabilities,
	on_attach = function(client, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end,
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
})

lspconfig.pyright.setup({})
-- lspconfig.html.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.rust_analyzer.setup({})

lspconfig.gopls.setup({})
-- lspconfig.prettier.setup({})

lspconfig.eslint.setup({
	-- Additional settings
	-- settings = {
	-- 	-- ...
	-- },
})
