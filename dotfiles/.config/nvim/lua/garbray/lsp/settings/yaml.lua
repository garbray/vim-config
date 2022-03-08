-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
    on_attach = require'garbray.lsp.handlers'.on_attach,
}

