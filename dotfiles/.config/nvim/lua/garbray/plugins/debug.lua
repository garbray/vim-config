return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",
	"jayp0521/mason-nvim-dap.nvim",
	"mfussenegger/nvim-dap-python",
	-- JS/TS debugging via mason js-debug-adapter
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
	},
}
