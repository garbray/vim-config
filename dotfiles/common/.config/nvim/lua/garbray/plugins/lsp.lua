-- LSP: server installation, attach keymaps, diagnostics UI.
return {
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
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
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp", "mason-org/mason-lspconfig.nvim" },
		config = function()
			-- one wildcard config instead of repeating capabilities per server
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("garbray-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local buf = vim.lsp.buf
					local map = function(mode, keys, fn, desc)
						vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
					end

					map("n", "<leader>gd", buf.definition, "Go to definition")
					map("n", "<leader>gr", buf.references, "Go to references")
					map("n", "<leader>vrr", buf.references, "View references")
					map("n", "K", buf.hover, "Hover documentation")
					map("n", "<leader>vws", buf.workspace_symbol, "Workspace symbol")
					map("n", "<leader>vd", vim.diagnostic.open_float, "Open diagnostics")
					map("n", "<leader>gn", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Go to next diagnostic")
					map("n", "<leader>gp", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Go to previous diagnostic")
					map("n", "<leader>ca", buf.code_action, "Code action")
					map("n", "<leader>rn", buf.rename, "Rename")
					map("i", "<C-h>", buf.signature_help, "Signature help")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})

			vim.lsp.enable(require("garbray.servers"))
		end,
	},
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		config = function()
			require("goto-preview").setup({
				width = 120,
				height = 15,
				border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
				default_mappings = true,
				debug = false,
				opacity = nil,
				resizing_mappings = false,
				post_open_hook = nil,
				references = {
					provider = "snacks",
				},
				focus_on_open = true,
				dismiss_on_move = false,
				force_close = true,
				bufhidden = "wipe",
				stack_floating_preview_windows = true,
				preview_window_title = { enable = true, position = "left" },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
}
