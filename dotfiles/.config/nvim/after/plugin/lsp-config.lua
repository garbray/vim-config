local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = capabilities,
})

lspconfig.pyright.setup({})
-- lspconfig.html.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.rust_analyzer.setup({})
