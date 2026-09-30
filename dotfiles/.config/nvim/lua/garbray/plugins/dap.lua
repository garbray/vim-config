-- Debugging. Adapters are installed by mason-tool-installer (see plugins/lsp.lua).
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
			{ "mfussenegger/nvim-dap-python", lazy = true },
			{ "nvim-telescope/telescope-dap.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
		},
		keys = {
			{
				"<leader>dt",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Dap toggle breakpoint",
			},
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Dap set conditional breakpoint",
			},
			{
				"<leader>lp",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Dap set log point",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Dap continue",
			},
			{
				"<leader>dr",
				function()
					require("dap").run_last()
				end,
				desc = "Dap run last",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Dap step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Dap step over",
			},
			{
				"<leader>du",
				function()
					require("dap").step_out()
				end,
				desc = "Dap step out",
			},
			{
				"<leader>dx",
				function()
					require("dapui").close()
				end,
				desc = "Dap UI close",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()
			require("dap-go").setup()

			-- debugpy comes from mason-tool-installer; fall back to PATH python
			local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(vim.uv.fs_stat(debugpy) and debugpy or "python3")

			pcall(require("telescope").load_extension, "dap")

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🐞", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define("DapBreakpointCondition", { text = "🕷️", texthl = "DapBreakpointCondition" })

			-- pick a process to attach to, through telescope
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
									coroutine.resume(coro, action_state.get_selected_entry().value)
								end)
								return true
							end,
						})
						:find()
				end)
			end

			-- JS/TS via mason's js-debug-adapter
			for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
						args = { "${port}" },
					},
				}
			end

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
						runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
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

			-- Rust via mason's codelldb
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

			-- open/close the UI around a session
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
		end,
	},
}
