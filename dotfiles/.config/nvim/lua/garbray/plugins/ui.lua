-- Statusline, notifications, command line and keymap hints.
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/noice.nvim" },
		event = "VeryLazy",
		opts = function()
			local noice = require("noice")
			return {
				options = {
					theme = "auto",
					section_separators = { "", "" },
					component_separators = { "", "" },
					icons_enabled = true,
				},
				-- shows the noice-recorded mode (macro recording, etc.)
				sections = {
					lualine_x = {
						{
							noice.api.statusline.mode.get,
							cond = noice.api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
				},
			}
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			notify = {
				enabled = false, -- use snacks.notifier instead
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
						},
					},
					opts = { skip = true },
				},
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
 ________  ________  ________  ________  ________  ________      ___    ___
|\   ____\|\   __  \|\   __  \|\   __  \|\   __  \|\   __  \    |\  \  /  /|
\ \  \___|\ \  \|\  \ \  \|\  \ \  \|\ /\ \  \|\  \ \  \|\  \   \ \  \/  / /
 \ \  \  __\ \   __  \ \   _  _\ \   __  \ \   _  _\ \   __  \   \ \    / /
  \ \  \|\  \ \  \ \  \ \  \\  \\ \  \|\  \ \  \\  \\ \  \ \  \   \/  /  /
   \ \_______\ \__\ \__\ \__\\ _\\ \_______\ \__\\ _\\ \__\ \__\__/  / /
    \|_______|\|__|\|__|\|__|\|__|\|_______|\|__|\|__|\|__|\|__|\___/ /
                                                               \|___|/
]],
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{ icon = " ", key = "i", desc = "Config", action = ":e ~/.config/nvim" },
						{ icon = " ", key = "z", desc = "Zshrc", action = ":e ~/.zshrc" },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "recent_files", limit = 8, padding = 1 },
					{ section = "startup" },
				},
			},
			indent = {
				enabled = true,
				indent = {
					char = "┊",
				},
			},
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = { enabled = true },
			quickfile = { enabled = true },
			terminal = {
				win = {
					position = "float",
				},
			},
			words = { enabled = true },
			styles = {
				notification = {},
			},
		},
		keys = {
			-- <leader>S -- snacks trial namespace. Runs alongside telescope
			-- (<leader>pf/<C-p>/<leader>ps) and simple-term (<leader>tu/<leader>te)
			-- so both can be compared. See docs/nvim-plan.md Tier 3b.
			{ "<leader>Sf", function() Snacks.picker.files() end, desc = "Picker: Files" },
			{ "<leader>Sg", function() Snacks.picker.grep() end, desc = "Picker: Live Grep" },
			{ "<leader>Sw", function() Snacks.picker.grep_word() end, desc = "Picker: Grep Word", mode = { "n", "x" } },
			{ "<leader>Sb", function() Snacks.picker.buffers() end, desc = "Picker: Buffers" },
			{ "<leader>Sr", function() Snacks.picker.recent() end, desc = "Picker: Recent Files" },
			{ "<leader>SS", function() Snacks.picker.lsp_symbols() end, desc = "Picker: Document Symbols" },
			{ "<leader>Sd", function() Snacks.picker.diagnostics() end, desc = "Picker: Diagnostics" },
			{ "<leader>Sh", function() Snacks.picker.help() end, desc = "Picker: Help Pages" },
			{ "<leader>Sk", function() Snacks.picker.keymaps() end, desc = "Picker: Keymaps" },
			{ "<leader>Sq", function() Snacks.picker.qflist() end, desc = "Picker: Quickfix List" },
			{ "<leader>Sc", function() Snacks.picker.git_log() end, desc = "Picker: Git Log" },
			{ "<leader>Su", function() Snacks.picker.undo() end, desc = "Picker: Undo History" },
			{ "<leader>Sp", function() Snacks.picker.pickers() end, desc = "Picker: All Pickers" },
			{ "<leader>St", function() Snacks.terminal.toggle() end, desc = "Snacks: Toggle Terminal" },
			-- replaces vim-bujo: a scratch buffer persisted per cwd + git branch
			{ "<leader>bt", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
			{ "<leader>bs", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gi",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.8,
						height = 0.8,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd

					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			-- Group labels. <leader>d, <leader>u, <leader>x and <leader>f are
			-- deliberately absent: each has a direct mapping that shadows the
			-- group, so labelling them would be misleading. See
			-- docs/nvim-plan.md Tier 2 for the full collision list.
			spec = {
				{ "<leader>a", group = "Harpoon" },
				{ "<leader>A", group = "AI / Claude Code" },
				{ "<leader>S", group = "Snacks (trial)" },
				{ "<leader>b", group = "Buffers / Scratch" },
				{ "<leader>c", group = "Code / Colors" },
				{ "<leader>g", group = "Git / Goto" },
				{ "<leader>p", group = "Project / Find" },
				{ "<leader>t", group = "Tabs / Terminals" },
				{ "<leader>v", group = "LSP view / Splits" },
			},
		},
		keys = {
			{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
		},
	},
}
