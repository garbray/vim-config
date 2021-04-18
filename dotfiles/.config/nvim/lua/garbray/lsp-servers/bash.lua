-- npm i -g bash-language-server
require'lspconfig'.bashls.setup {
    on_attach = require'garbray.config'.common_on_attach,
    filetypes = { "sh", "zsh" }
}

