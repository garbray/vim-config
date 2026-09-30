return {
	"nvim-lualine/lualine.nvim",
	-- vim-startify removed - using snacks.dashboard
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	-- "lukas-reineke/indent-blankline.nvim",
	--  { "catppuccin/nvim", as = "catppuccin" },
	--"folke/twilight.nvim", -- this could be removed in favor of snack dim
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			-- colorscheme + transparent background, in one place.
			-- Exposed globally so <leader>cp can re-apply it after a plugin reload.
			_G.ColorMyPencils = function(color)
				vim.cmd.colorscheme(color or "rose-pine")
				for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn" }) do
					vim.api.nvim_set_hl(0, group, { bg = "none" })
				end
				vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#21262d" })
				vim.api.nvim_set_hl(0, "LineNr", { fg = "#d35e5e" })
				vim.api.nvim_set_hl(0, "netrwDir", { fg = "#5eacd3" })
				vim.api.nvim_set_hl(0, "qfFileName", { fg = "#aed75f" })
			end
			ColorMyPencils()
		end,
		keys = {
			{
				"<leader>cp",
				function()
					ColorMyPencils()
				end,
				desc = "Re-apply colorscheme + transparency",
			},
		},
	},
}
