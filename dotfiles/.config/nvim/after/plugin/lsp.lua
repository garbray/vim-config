local ok_blink, blink = pcall(require, "blink.cmp")
if not ok_blink then
	return
end

-- One wildcard config instead of repeating capabilities/on_attach per server.
vim.lsp.config("*", {
	capabilities = blink.get_lsp_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("garbray-lsp-attach", { clear = true }),
	callback = function(event)
		local bufnr = event.buf
		local buf = vim.lsp.buf
		local map = function(mode, keys, fn, desc)
			vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		map("n", "<leader>gd", buf.definition, "Go to definition")
		map("n", "<leader>gr", buf.references, "Go to references")
		map("n", "<leader>vrr", buf.references, "View references")
		map("n", "K", buf.hover, "Hover documentation")
		map("n", "<leader>vws", buf.workspace_symbol, "Workspace symbol")
		map("n", "<leader>vd", vim.diagnostic.open_float, "Open diagnostics")
		map("n", "<leader>gn", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Go to next diagnostic")
		map("n", "<leader>gp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Go to previous diagnostic")
		map("n", "<leader>ca", buf.code_action, "Code action")
		map("n", "<leader>rn", buf.rename, "Rename")
		map("i", "<C-h>", buf.signature_help, "Signature help")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
})

vim.lsp.enable(require("garbray.servers"))
