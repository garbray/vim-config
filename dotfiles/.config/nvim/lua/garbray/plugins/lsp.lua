return {
	-- lazydev.nvim for Lua development (vim globals, etc.)
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	-- package manager
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- formatters
				"stylua",
				"eslint_d",
				"prettier",
				"prettierd",
				-- code spell
				"codespell",
				"misspell",
				"cspell",
				-- markdown
				"markdownlint",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",
				"eslint",
				"jsonls",
				"html",
				"bashls",
				"dockerls",
				"yamlls",
				"marksman",
				"sqlls",
				"vimls",
				"tailwindcss",
				"pyright",
				"gopls",
				"jdtls",
				"rust_analyzer",
				-- "roslyn",
				"omnisharp",
			},
		},
	},
	-- blink.cmp - modern completion engine (replaces nvim-cmp)
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"giuxtaposition/blink-cmp-copilot",
				dependencies = { "zbirenbaum/copilot.lua" },
			},
		},
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
			},
			sources = {
				default = { "copilot", "lsp", "path", "snippets", "buffer" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "williamboman/mason-lspconfig.nvim" },
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	-- {
	-- 	"seblyng/roslyn.nvim",
	-- 	---@module 'roslyn.config'
	-- 	---@type RoslynNvimConfig
	-- 	opts = {
	-- 		-- your configuration comes here; leave empty for default settings
	-- 	},
	-- },
}
