local lsp_zero = require("lsp-zero")
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local keymap = vim.keymap.set
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp_zero.preset("recommended")
lsp_zero.setup({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"rust_analyzer",
})

lsp_zero.set_preferences({
	sign_icons = {},
})

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	keymap("n", "gd", function()
		buf.definition()
	end, opts)
	keymap("n", "K", function()
		buf.hover()
	end, opts)
	keymap("n", "<leader>vws", function()
		buf.workspace_symbol()
	end, opts)
	keymap("n", "<leader>vd", function()
		diagnostic.open_float()
	end, opts)
	keymap("n", "<leader>gn", function()
		diagnostic.goto_next()
	end, opts)
	keymap("n", "<leader>gp", function()
		diagnostic.goto_prev()
	end, opts)
	-- keymap("n", "<leader>ca", function()
	-- 	buf.code_action()
	-- end, opts)
	keymap("n", "<leader>ca", "<cmd>Lspsaga code_action end<CR>", {})
	keymap("n", "<leader>vrr", function()
		buf.references()
	end, opts)
	keymap("n", "<leader>vrn", function()
		buf.rename()
	end, opts)
	keymap("i", "<C-h>", function()
		buf.signature_help()
	end, opts)
end)

-- lsp.setup()
require("lspconfig").tsserver.setup({
	capabilities = lsp_capabilities,
	on_attach = function(client, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end,
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "rust_analyzer" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})
