-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

local install_path = vim.fn.stdpath("data") .. "/.local/share/nvim/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- color schemas
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use("gruvbox-community/gruvbox")

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	use("folke/neodev.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("tpope/vim-sleuth")
	use("lewis6991/gitsigns.nvim")

	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("plasticboy/vim-markdown")
	use("nvim-lualine/lualine.nvim")
	use("vuciv/vim-bujo")
	use("lukas-reineke/indent-blankline.nvim")
	use("andymass/vim-matchup")

	-- maybe not necessary
	use("preservim/tagbar")
	use("mhinz/vim-startify")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga()
		end,
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- github
	use("tyru/open-browser.vim")
	use("tyru/open-browser-github.vim")

	-- Dap
	use("mfussenegger/nvim-dap")
	use("jayp0521/mason-nvim-dap.nvim")
	use("rcarriga/nvim-dap-ui")
	-- Plug 'theHamsta/nvim-dap-virtual-text'
end)
