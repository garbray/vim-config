-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
    root_dir = require'lspconfig'.util.root_pattern('package.json', 'tsconfig.json', '.git/'),
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

