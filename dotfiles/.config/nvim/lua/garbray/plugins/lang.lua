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
}
