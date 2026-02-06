local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	return
end

-- Load telescope-dap extension
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	telescope.load_extension("dap")
end

-- Helper to pick process with telescope
local function pick_process_telescope()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	return coroutine.create(function(coro)
		local processes = require("dap.utils").get_processes()
		pickers
			.new({}, {
				prompt_title = "Select Process",
				finder = finders.new_table({
					results = processes,
					entry_maker = function(entry)
						return {
							value = entry.pid,
							display = string.format("%d: %s", entry.pid, entry.name),
							ordinal = entry.name,
						}
					end,
				}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(bufnr)
					actions.select_default:replace(function()
						actions.close(bufnr)
						local selection = action_state.get_selected_entry()
						coroutine.resume(coro, selection.value)
					end)
					return true
				end,
			})
			:find()
	end)
end

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
		"js",
		"codelldb",
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

-- JS/TS debugging setup via js-debug-adapter (Mason)
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
		args = { "${port}" },
	},
}

dap.adapters["pwa-chrome"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
		args = { "${port}" },
	},
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = pick_process_telescope,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
		},
	}
end

-- Rust debugging setup
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

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
	dap.run_last()
end, { noremap = true, silent = true, desc = "Dap Run Last" })
vim.keymap.set("n", "<leader>dx", function()
	dapui.close()
end, { noremap = true, silent = true, desc = "Dap UI close" })
vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true, silent = true, desc = "Dap step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { noremap = true, silent = true, desc = "Dap step over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { noremap = true, silent = true, desc = "Dap step out" })
vim.keymap.set(
	"n",
	"<leader>lp",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
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
