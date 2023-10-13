require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "c", "lua", "rust" },
	-- 	parser_install_dir = "~/.treesitter/parsers",
	-- 	sync_install = false,
	auto_install = true,
	-- 	-- List of parsers to ignore installing (for "all")
	-- 	-- ignore_install = { "javascript" },
	-- 	highlight = {
	-- 		enable = true,
	-- 		additional_vim_regex_highlighting = false,
	-- 	},
	-- nvim-ts-autotag
	autotag = {
		enable = true,
	},
})

-- auto pairs complete
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})
