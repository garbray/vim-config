return {
	-- "github/copilot.vim",
	{
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	-- copilot completion now handled by blink-cmp-copilot in lsp.lua
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "copilot",
						tools = {
							opts = {
								-- Auto-load these tools in every chat
								default_tools = { "full_stack_dev" },
							},
							-- Configure individual tool behavior
							["insert_edit_into_file"] = {
								opts = {
									requires_approval = {
										buffer = false, -- No approval for buffer edits
										file = true, -- Require approval for file edits
									},
								},
							},
							["create_file"] = {
								opts = {
									requires_approval = true,
								},
							},
							["cmd_runner"] = {
								opts = {
									requires_approval = true,
								},
							},
						},
					},
					inline = { adapter = "copilot" },
				},
				display = {
					diff = {
						enabled = true,
						provider = "mini_diff",
					},
				},
			})
		end,
		keys = {
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
			{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
		},
	},
}
