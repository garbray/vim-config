require'lspconfig'.gopls.setup{
    on_attach = require'garbray.lsp.handlers'.on_attach
}
