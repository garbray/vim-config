-- npm install -g vim-language-server
require'lspconfig'.vimls.setup {
    on_attach = require'garbray.config'.common_on_attach
}
