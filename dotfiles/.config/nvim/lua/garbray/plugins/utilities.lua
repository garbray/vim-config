return {
	"prisma/vim-prisma",
	-- markdown
	"plasticboy/vim-markdown",

	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- nvim-notify removed - using snacks.notifier
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

	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	config = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- },
	{
		"mistricky/codesnap.nvim",
		build = "make",
		-- keys = {
		-- 	{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
		-- 	{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		-- },
		opts = {
			save_path = "~/Pictures",
			has_breadcrumbs = true,
			-- bg_theme = "bamboo",
			bg_color = "#535c68",
			has_line_number = true,
			watermark = "",
		},
	},
	-- multiple plugin
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
			quickfile = { enabled = true },
			terminal = {
				win = {
					position = "float",
				},
			},
			words = { enabled = true },
			styles = {
				notification = {
					-- wo = { wrap = true } -- Wrap notifications
				},
			},
		},
		keys = {
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
				"<leader>gB", -- opens the current file in the browser
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
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
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

	-- { "mistweaverco/kulala.nvim", opts = {} },
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*", -- recommended, use latest release instead of latest commit
	-- 	lazy = true,
	-- 	ft = "markdown",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },
	-- currently is not working properly
	--
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	--"folke/lazydev.nvim", -- lua language server
	--"folke/twilight.nvim", -- this could be removed in favor of snack dim
	-- { "echasnovski/mini.nvim", version = false },
	-- zen-mode.nvim removed - using Snacks.zen()
	-- this one looks unnecessary
	-- commands gpd - gpr -gP
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 15, -- Height of the floating window
				border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
				default_mappings = true,
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				references = { -- Configure the telescope UI for slowing the references cycling window.
					telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
				},
				-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
				focus_on_open = true, -- Focus the floating window when opening it.
				dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
				force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
				bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
				stack_floating_preview_windows = true, -- Whether to nest floating windows
				preview_window_title = { enable = true, position = "left" }, -- Whether
			})
		end,
	},

	-- language specific stuff
	--"ray-x/go.nvim",
	--"ray-x/guihua.lua",

	-- trouble.nvim - better diagnostics list
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},

	-- which-key.nvim - keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
		},
		keys = {
			{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
		},
	},
}
