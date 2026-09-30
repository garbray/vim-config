return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash", "c", "c_sharp", "css", "diff", "go", "html",
				"javascript", "json", "jsonc", "lua", "luadoc",
				"markdown", "markdown_inline", "python", "query",
				"rust", "sql", "toml", "tsx", "typescript",
				"vim", "vimdoc", "yaml",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	"mbbill/undotree",
	"tpope/vim-fugitive",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	"tpope/vim-sleuth",
	"lewis6991/gitsigns.nvim",
	-- maybe those could be in another file
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- flash.nvim - modern motion plugin (like sneak/hop)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
