require("lualine").setup({
	options = {
		theme = "gruvbox",
		section_separators = { "", "" },
		component_separators = { "", "" },
		icons_enabled = true,
	},
	-- this sync with folke/noice plugin
	sections = {
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
