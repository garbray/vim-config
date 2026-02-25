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
		config = function()
			local buf = vim.lsp.buf
			local diagnostic = vim.diagnostic
			local keymap = vim.keymap.set
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local on_attach = function(_, bufnr)
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
			end

			-- Mason-lspconfig handlers
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})

			-- Server-specific overrides
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			lspconfig.vtsls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							variableTypes = { enabled = true },
							returnTypes = { enabled = true },
						},
					},
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
					},
				},
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		opts = {},
	},
}
