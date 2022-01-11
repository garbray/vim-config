-- npm install -g vim-language-server
require'lspconfig'.vimls.setup {
    on_attach = require'garbray.lsp.handlers'.on_attach
}
