return {
	-- lazydev.nvim for Lua development (vim globals, etc.)
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	-- package manager
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = require("garbray.servers"),
			-- servers are enabled explicitly in after/plugin/lsp.lua
			automatic_enable = false,
		},
	},
	-- mason.nvim itself has no ensure_installed; this installs formatters/linters/debuggers
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- formatters
				"stylua",
				"prettierd",
				"prettier",
				"black",
				"isort",
				"shfmt",
				"goimports",
				-- linters
				"eslint_d",
				"markdownlint",
				"codespell",
				-- debug adapters (were mason-nvim-dap's ensure_installed)
				"debugpy",
				"delve",
				"js-debug-adapter",
				"codelldb",
			},
			run_on_start = false,
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
		dependencies = { "saghen/blink.cmp", "mason-org/mason-lspconfig.nvim" },
	},
	-- formatting: single source of truth (after/plugin/conform.lua removed)
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofmt" },
				sh = { "shfmt" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = { lsp_format = "fallback", timeout_ms = 3000 },
			notify_on_error = true,
		},
	},
}
