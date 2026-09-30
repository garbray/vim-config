return {
	{ "windwp/nvim-ts-autotag", opts = {} },
	"prisma/vim-prisma",
	-- markdown rendered in-buffer via treesitter, instead of a browser preview
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown" },
		opts = {},
	},
}
