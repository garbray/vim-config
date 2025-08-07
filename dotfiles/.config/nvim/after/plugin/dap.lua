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
require("nvim-dap-virtual-text").setup()
vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapBreakpointCondition", { text = "⭕️" })

-- follow the instructions here https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
-- dap.adapters["pwa-node"] = {
-- 	type = "server",
-- 	host = "localhost",
-- 	port = "${port}",
-- 	executable = {
-- 		command = "node",
-- 		-- 💀 Make sure to update this path to point to your installation
-- 		args = { "~/.debug/js-debug/src/dapDebugServer.js", "${port}" },
-- 	},
-- }

-- dap.configurations.javascript = {
-- 	{
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch file",
-- 		program = "${file}",
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }

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
