local lsp = require("lsp-zero")
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local keymap = vim.keymap.set

lsp.preset("recommended")
lsp.setup({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"rust_analyzer",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = {},
})

lsp.on_attach(function(client, bufnr)
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
		buf.referencees()
	end, opts)
	keymap("n", "<leader>vrn", function()
		buf.rename()
	end, opts)
	keymap("i", "<C-h>", function()
		buf.signature_help()
	end, opts)
end)

lsp.setup()
