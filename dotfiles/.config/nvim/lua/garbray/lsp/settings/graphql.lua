-- npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup {
    on_attach = require'garbray.lsp.handlers'.on_attach,
}

