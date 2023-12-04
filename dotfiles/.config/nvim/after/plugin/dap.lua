local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

-- local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
-- if not mason_nvim_dap_ok then
-- 	return
-- end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local keymap = vim.keymap.set

mason.setup({})
require("mason-nvim-dap").setup({
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
	javascript = function(config)
		config.adapters = {
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
	end,
})
-- mason_nvim_dap.setup({
-- 	ensure_installed = { "python", "delve", "node2", "chrome", "firefox" },
-- 	-- automatic_setup = true,
-- })

-- mason_nvim_dap.setup({
-- 	handlers = {
-- 		function(config)
-- 			-- all sources with no handler get passed here

-- 			-- Keep original functionality of `automatic_setup = true`
-- 			require("mason-nvim-dap").default_setup(config)
-- 		end,
-- 	},
-- 	node2 = function(config)
-- 		config.adapters = {
-- 			type = "executable",
-- 			command = "node",
-- 			args = { os.getenv("HOME") .. "/.config/adapters/vscode-node-debug2/out/src/nodeDebug.js" },
-- 		}
-- 		print(config)
-- 		require("mason-nvim-dap").default_setup(config)
-- 	end,
-- 	-- python = function(source_name)
-- 	-- 	dap.adapters.python = {
-- 	-- 		type = "executable",
-- 	-- 		command = "/usr/bin/python3",
-- 	-- 		args = {
-- 	-- 			"-m",
-- 	-- 			"debugpy.adapter",
-- 	-- 		},
-- 	-- 	}

-- 	-- 	dap.configurations.python = {
-- 	-- 		{
-- 	-- 			type = "python",
-- 	-- 			request = "launch",
-- 	-- 			name = "Launch file",
-- 	-- 			program = "${file}", -- This configuration will launch the current file if used.
-- 	-- 		},
-- 	-- 	}
-- 	-- end,
-- })

-- -- keymaping
keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
keymap("n", "<leader>do", ":lua require'dap'.step_out()<CR>")
keymap("n", "<leader>ds", ":lua require'dap'.step_over()<CR>")
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nill, nill, vim.fn.input('Log point message: '))<CR>")
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
keymap("n", "<leader>da", ":lua require'garbray.plugins.debugHelper'.attach()<CR>")

-- config
-- language
-- dap.adapters["pwa-node"] = {
-- 	type = "server",
-- 	host = "localhost",
-- 	port = "9229",
-- 	executable = {
-- 		command = "js-debug-adapter",
-- 	},
-- }

-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	dap.configurations[language] = {
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 		},
-- 	}
-- end

-- dap.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/.config/adapters/vscode-node-debug2/out/src/nodeDebug.js" },
-- }

-- local opts = { noremap = false, silent = true }
-- -- require("nvim-dap-virtual-text").setup()
