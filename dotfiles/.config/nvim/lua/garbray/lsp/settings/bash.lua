-- npm i -g bash-language-server
require'lspconfig'.bashls.setup {
    on_attach = require'garbray.lsp.handlers'.on_attach,
    filetypes = { "sh", "zsh" }
}

