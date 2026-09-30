-- AI assistance.
return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {},
		keys = {
			{ "<leader>A", nil, desc = "AI / Claude Code" },
			{ "<leader>Ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>Af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>Ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>AC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>Am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>Ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>As", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
			{
				"<leader>AS",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file from tree",
				ft = { "netrw", "oil", "minifiles", "NvimTree", "neo-tree" },
			},
			-- deliberately not <leader>Aa: upstream binds DiffAccept there, which is
			-- easy to hit by accident
			{ "<leader>Ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>An", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
