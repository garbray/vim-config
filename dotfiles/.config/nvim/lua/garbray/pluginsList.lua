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
		"jcdickinson/http.nvim",
		run = "cargo build --workspace --release",
	})

	use({
		"jcdickinson/codeium.nvim",
		requires = {
			"jcdickinson/http.nvim",
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" },
		},
	})
	use("folke/neodev.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"linux-cultist/venv-selector.nvim",
		reqires = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
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
	})

	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("tpope/vim-sleuth")
	use("lewis6991/gitsigns.nvim")
	-- use("preservim/nerdtree")

	-- IA tab nine
	-- use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
	-- use({ "codota/tabnine-nvim", run = "./dl_binaries.sh" })

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("prisma/vim-prisma")

	use("plasticboy/vim-markdown")
	use("nvim-lualine/lualine.nvim")
	use("vuciv/vim-bujo")
	use("lukas-reineke/indent-blankline.nvim")
	use("andymass/vim-matchup")

	-- maybe not necessary
	use("preservim/tagbar")
	use("mhinz/vim-startify")
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
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
	--
	use({
		"samodostal/image.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
end)
