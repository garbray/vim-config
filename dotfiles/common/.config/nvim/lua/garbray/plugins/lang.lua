-- Language-specific extras.
return {
	"prisma/vim-prisma",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown" },
		opts = {},
	},
	{
		-- Browser preview for markdown/html/asciidoc/svg. Pure Lua, no node/deno.
		"brianhuster/live-preview.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = { "LivePreview" },
		keys = {
			{ "<leader>mp", "<cmd>LivePreview start<cr>", desc = "Markdown preview (browser)" },
			{ "<leader>mq", "<cmd>LivePreview close<cr>", desc = "Markdown preview stop" },
			{ "<leader>mf", "<cmd>LivePreview pick<cr>", desc = "Markdown preview pick file" },
		},
		config = function()
			require("livepreview.config").set({
				picker = "snacks.picker",
				sync_scroll = true,
			})
		end,
	},
}
