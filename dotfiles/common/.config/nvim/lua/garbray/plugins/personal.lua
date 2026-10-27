-- Own plugins.
return {
	{
		"garbray/simple-term",
		keys = {
			{
				"<leader>tu",
				function()
					require("simple-term").goto_terminal(1)
				end,
				desc = "Simple-term: terminal 1",
			},
			{
				"<leader>te",
				function()
					require("simple-term").goto_terminal(2)
				end,
				desc = "Simple-term: terminal 2",
			},
		},
	},
}
