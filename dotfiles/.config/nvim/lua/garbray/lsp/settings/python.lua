-- npm i -g pyright
require'lspconfig'.pyright.setup {
    on_attach = require'garbray.lsp.handlers'.on_attach,
    -- handlers = {
    --     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --         virtual_text = O.python.diagnostics.virtual_text,
    --         signs = O.python.diagnostics.signs,
    --         underline = O.python.diagnostics.underline,
    --         update_in_insert = true,
    --     })
    -- }
}
