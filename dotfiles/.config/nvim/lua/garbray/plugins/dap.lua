local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_status_ok then
	return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
	return
end

vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>ds", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set(
	"n",
	"<leader>lp",
	":lua require'dap'.set_breakpoint(nill, nill, vim.fn.input('Log point message: '))<CR>"
)
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>da", ":lua require'garbray.plugins.debugHelper'.attach()<CR>")

-- vim.keymap.set(n, '<leader>dk', function() require('dap').continue() end)
-- vim.keymap.set(n, '<leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set("n", "<leader>ec", function()
-- 	dap.toggle_breakpoint()
-- end)
-- vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

local opts = { noremap = false, silent = true }
require("nvim-dap-virtual-text").setup()

dap_install.setup({})
dap_install.config("python", {})
-- dap_install.config("jsnode")

require("dapui").setup({
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
})

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/.config/adapters/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
