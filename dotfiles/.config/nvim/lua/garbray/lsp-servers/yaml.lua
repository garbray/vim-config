-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
    on_attach = require'garbray.config'.common_on_attach,
}

