return {
	"nvim-lualine/lualine.nvim",
	"vuciv/vim-bujo",
	"preservim/tagbar",
	-- vim-startify removed - using snacks.dashboard
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
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
}
