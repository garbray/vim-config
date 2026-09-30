-- Colorscheme and transparency.
return {
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

				-- Floating terminals keep a solid background: with Normal and
				-- NormalFloat blanked above, snacks floats inherit "no background"
				-- and the terminal renders straight over the buffer behind it.
				-- local ok, palette = pcall(require, "rose-pine.palette")
				-- local float_bg = ok and palette.overlay or "#26233a"
				-- vim.api.nvim_set_hl(0, "SnacksTerminalNormal", { bg = float_bg })
				-- vim.api.nvim_set_hl(0, "SnacksTerminalBorder", { bg = float_bg, fg = ok and palette.muted or "#6e6a86" })
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
