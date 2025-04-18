return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",
	"jayp0521/mason-nvim-dap.nvim",
}

--{
--	"rcarriga/nvim-dap-ui",
--	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
--},
--"theHamsta/nvim-dap-virtual-text",
--"leoluz/nvim-dap-go",
---- "mfussenegger/nvim-dap",
--"jayp0521/mason-nvim-dap.nvim",
---- {
---- 	"rcarriga/nvim-dap-ui",
---- 	dependencies = "mfussenegger/nvim-dap",
---- 	config = function()
---- 		local dap = require("dap")
---- 		local dapui = require("dapui")
---- 		require("dapui").setup()

---- 		dap.listeners.after.event_initialized["dapui_config"] = function()
---- 			dapui.open()
---- 		end
---- 		dap.listeners.before.event_terminated["dapui_config"] = function()
---- 			dapui.close()
---- 		end
---- 		dap.listeners.before.event_exited["dapui_config"] = function()
---- 			dapui.close()
---- 		end
---- 	end,
---- },
---- "theHamsta/nvim-dap-virtual-text",
---- {
---- 	"samodostal/image.nvim",
---- 	dependencies = {
---- 		"nvim-lua/plenary.nvim",
---- 	},
---- },
---- {
---- 	"rest-nvim/rest.nvim",
---- 	-- "NTBBloodbath/rest.nvim",
---- 	dependencies = { "nvim-lua/plenary.nvim" },
---- 	ensure_installed = { "http", "json" },
---- },
