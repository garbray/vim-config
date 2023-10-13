local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_ok then
	return
end

local keymap = vim.keymap.set

require("mason").setup()
mason_nvim_dap.setup({
	ensure_installed = { "python", "delve", "node2", "chrome", "firefox" },
	automatic_setup = true,
})

-- mason_nvim_dap.setup_handlers({
-- 	function(source_name)
-- 		-- all sources with no handler get passed here

-- 		-- Keep original functionality of `automatic_setup = true`
-- 		require("mason-nvim-dap.automatic_setup")(source_name)
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
-- keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
-- keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
-- keymap("n", "<leader>do", ":lua require'dap'.step_out()<CR>")
-- keymap("n", "<leader>ds", ":lua require'dap'.step_over()<CR>")
-- keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
-- keymap("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nill, nill, vim.fn.input('Log point message: '))<CR>")
-- keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
-- keymap("n", "<leader>da", ":lua require'garbray.plugins.debugHelper'.attach()<CR>")

-- -- dap.adapters.node2 = {
-- -- 	type = "executable",
-- -- 	command = "node",
-- -- 	args = { os.getenv("HOME") .. "/.config/adapters/vscode-node-debug2/out/src/nodeDebug.js" },
-- -- }

-- local opts = { noremap = false, silent = true }
-- -- require("nvim-dap-virtual-text").setup()
