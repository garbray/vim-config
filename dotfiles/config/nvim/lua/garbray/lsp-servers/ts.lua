-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
    capabilities = require'garbray.config'.capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
    on_attach = require'garbray.config'.tsserver_on_attach,
    settings = {documentFormatting = false},
}


