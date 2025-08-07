return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 500,
			spec = {
				{ "<leader>wf", group = "find" },
				{ "<leader>wg", group = "git" },
				{ "<leader>wl", group = "lsp" },
				{ "<leader>wt", group = "toggle/test" },
				{ "<leader>ws", group = "search" },
				{ "<leader>wd", group = "diagnostics" },
				{ "<leader>ww", group = "window" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}

