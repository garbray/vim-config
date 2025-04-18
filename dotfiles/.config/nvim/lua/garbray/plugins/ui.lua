return {
	"nvim-lualine/lualine.nvim",
	"vuciv/vim-bujo",
	"preservim/tagbar",
	"mhinz/vim-startify",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	-- "lukas-reineke/indent-blankline.nvim",
	--  { "catppuccin/nvim", as = "catppuccin" },
	--"folke/twilight.nvim", -- this could be removed in favor of snack dim
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},

	--{
	--	"nvimdev/lspsaga.nvim",
	--	after = "nvim-lspconfig",
	--	config = function()
	--		require("lspsaga").setup({})
	--	end,
	--},
}
