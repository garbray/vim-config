-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		-- or
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	-- plugins
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	"nvim-treesitter/playground",
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"tpope/vim-sleuth",
	"lewis6991/gitsigns.nvim",
	-- terminal
	-- "voldikss/vim-floaterm",
	-- colorschema
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	"gruvbox-community/gruvbox",
	-- package manager
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				-- formatters
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
	{ "williamboman/mason-lspconfig.nvim" },
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
	},
	{ "neovim/nvim-lspconfig" },
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
					-- TODO move into a module
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
			"VonHeikemen/lsp-zero.nvim",
		},
	},
	-- IA
	-- {
	-- 	"jcdickinson/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	{ "zbirenbaum/copilot.lua" },
	"github/copilot.vim",
	{
		"zbirenbaum/copilot-cmp",
		after = {
			"github/copilot.vim",
			"nvim-cmp",
		},
		config = function()
			local status, copilot_cmp = pcall(require, "copilot_cmp")
			if not status then
				return
			end

			copilot_cmp.setup({})
			-- require("copilot_cmp").setup()
		end,
	},
	-- {'gptlang/CopilotChat.nvim'} // review if this makes sense
	"folke/neodev.nvim",
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {

			"davidmh/cspell.nvim",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"davidmh/cspell.nvim",
		},
	},

	-- python
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		-- config = true,
		-- event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		-- keys = {
		-- 	{
		-- 		"<leader>vs",
		-- 		"<cmd>:VenvSelect<cr>",
		-- 		-- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
		-- 		"<leader>vc",
		-- 		"<cmd>:VenvSelectCached<cr>",
		-- 	},
		-- },
	},
	"interdependence/tree-sitter-htmldjango",

	"prisma/vim-prisma",

	"plasticboy/vim-markdown",
	"nvim-lualine/lualine.nvim",
	"vuciv/vim-bujo",
	"lukas-reineke/indent-blankline.nvim",

	"preservim/tagbar",
	"mhinz/vim-startify",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	{
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- github
	"tyru/open-browser.vim",
	{

		"tyru/open-browser-github.vim",
		dependencies = {
			"tyru/open-browser.vim",
		},
	},

	-- Dap
	-- "mfussenegger/nvim-dap",
	-- "jayp0521/mason-nvim-dap.nvim",
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	dependencies = "mfussenegger/nvim-dap",
	-- 	config = function()
	-- 		local dap = require("dap")
	-- 		local dapui = require("dapui")
	-- 		require("dapui").setup()

	-- 		dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 	end,
	-- },
	-- "theHamsta/nvim-dap-virtual-text",
	-- {
	-- 	"samodostal/image.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	-- "NTBBloodbath/rest.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	ensure_installed = { "http", "json" },
	-- },

	{
		"folke/zen-mode.nvim",
		opts = {},
	},
	-- newest
	{ "echasnovski/mini.nvim", version = false },
	{
		"mistricky/codesnap.nvim",
		build = "make",
		keys = {
			{ "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
			{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		},
		opts = {
			save_path = "~/Pictures",
			has_breadcrumbs = true,
			-- bg_theme = "bamboo",
			bg_color = "#535c68",
			has_line_number = true,
			watermark = "",
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- maybe the next theme
	-- { "catppuccin/nvim", as = "catppuccin" },
}, {})
