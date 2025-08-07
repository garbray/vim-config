return {
	-- package manager
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"gopls",
				"jdtls",
				"rust_analyzer",
				-- formatters
				"eslint_d",
				"prettier",
				"prettierd",
				-- code spell
				"codespell",
				"misspell",
				"cspell",
				-- LSP servers
				"jsonls",
				"tsserver",
				"html",
				"bashls",
				"dockerls",
				"yamlls",
				"marksman",
				"sqlls",
				"vimls",
				-- markdown
				"markdownlint",
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
	},
	{ "neovim/nvim-lspconfig" },
	-- Note: blink.cmp replaces nvim-cmp and is configured in blink-cmp.lua

	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					-- vscode format
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = vim.g.vscode_snippets_path or "",
					})
					-- snipmate format
					require("luasnip.loaders.from_snipmate").load()
					require("luasnip.loaders.from_snipmate").lazy_load({
						paths = vim.g.snipmate_snippets_path or "",
					})
					-- lua format
					require("luasnip.loaders.from_lua").load()
					require("luasnip.loaders.from_lua").lazy_load({
						paths = vim.g.lua_snippets_path or "",
					})
				end,
			},
			"hrsh7th/nvim-cmp",
			"onsails/lspkind.nvim",
		},
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		opts = {},
	},
}
