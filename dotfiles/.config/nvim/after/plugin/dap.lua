local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	return
end

mason.setup({})

require("mason-nvim-dap").setup({
	automatic_setup = true,
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
	ensure_installed = {
		"python",
		"delve",
		"node2",
		"chrome",
		"firefox",
	},
})

require("dapui").setup()
require("dap-go").setup()
require("dap-python").setup()

-- it may require use virtual envs to work properly, follow these steps
-- mkdir ~/.virtualenvs
-- cd ~/.virtualenvs
-- python -m venv debugpy
-- debugpy/bin/python -m pip install debugpy

require("nvim-dap-virtual-text").setup()

-- 
vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "🐞", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapBreakpointCondition", { text = "🕷️", texthl = "DapBreakpointCondition" })

-- follow the instructions here https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
-- https://github.com/mxsdev/nvim-dap-vscode-js?tab=readme-ov-file
-- require("dap-vscode-js").setup({
-- 	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
-- 	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
-- 	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
-- 	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
-- 	debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- adjust to your lazy.nvim dir
-- 	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
-- 	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
-- 	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
-- })

-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	dap.configurations[language] = {
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file",
-- 			program = "${file}",
-- 			-- cwd = "${workspaceFolder}",
-- 			cwd = vim.fn.getcwd(),
-- 		},
-- 		{
-- 			type = "pwa-node",
-- 			request = "attach",
-- 			name = "Attach",
-- 			processId = require("dap.utils").pick_process,
-- 			cwd = "${workspaceFolder}",
-- 		},
-- {
-- 	type = "pwa-node",
-- 	request = "launch",
-- 	name = "Debug Jest Tests",
-- 	-- trace = true, -- include debugger info
-- 	runtimeExecutable = "node",
-- 	runtimeArgs = {
-- 		"./node_modules/jest/bin/jest.js",
-- 		"--runInBand",
-- 	},
-- 	rootPath = "${workspaceFolder}",
-- 	cwd = "${workspaceFolder}",
-- 	console = "integratedTerminal",
-- 	internalConsoleOptions = "neverOpen",
-- },
-- }
-- end

-- Keymaps
vim.keymap.set(
	"n",
	"<leader>dt",
	dap.toggle_breakpoint,
	{ noremap = true, silent = true, desc = "Dap toggle breakpoint" }
)
vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Dap Set conditional Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true, desc = "Dap toggle breakpoint" })
vim.keymap.set("n", "<leader>dr", function()
	-- dapui:open({ reset = true })
	dap.continue()
end, { noremap = true, silent = true, desc = "Dap Run" })
vim.keymap.set("n", "<leader>dx", function()
	dapui:close()
end, { noremap = true, silent = true, desc = "Dap UI close" })
vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true, silent = true, desc = "Dap step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { noremap = true, silent = true, desc = "Dap step over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { noremap = true, silent = true, desc = "Dap step out" })
vim.keymap.set(
	"n",
	"<leader>lp",
	":lua require'dap'.set_breakpoint(nill, nill, vim.fn.input('Log point message: '))<CR>"
)

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
