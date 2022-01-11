require'lspconfig'.terraformls.setup{
    on_attach = require'garbray.lsp.handlers'.on_attach,
}
