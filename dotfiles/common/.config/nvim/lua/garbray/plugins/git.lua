-- Git signs and porcelain.
return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gs", vim.cmd.Git, desc = "Git status (fugitive)" },
			{ "<leader>ga", ":Git fetch --all<CR>", desc = "Git fetch --all" },
			{ "<leader>grum", ":Git rebase upstream/master<CR>", desc = "Git rebase upstream/master" },
			{ "<leader>grom", ":Git rebase origin/master<CR>", desc = "Git rebase origin/master" },
			-- merge conflict resolution
			{ "<leader>gj", ":diffget //3<CR>", desc = "Diffget from right (theirs)" },
			{ "<leader>gf", ":diffget //2<CR>", desc = "Diffget from left (ours)" },
		},
	},
}
