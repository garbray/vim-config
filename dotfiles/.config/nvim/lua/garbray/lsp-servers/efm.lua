local nvim_lsp = require('lspconfig')

local on_attach = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup lsp_formatting]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync({}, 1000)]]
    vim.cmd [[augroup END]]
  end
end

local efm_formatters = {
  prettier = {
    formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
    formatStdin = true,
    rootMarkers = {'package.json'},
  },
  eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
  }
}

-- npm install -g eslint_d
nvim_lsp.efm.setup({
  on_attach = on_attach,
  cmd = {'efm-langserver', '-logfile', '/tmp/efm.log', '-loglevel', '5'},
  init_options = {
    documentFormatting = true,
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
  settings = {
    rootMarkers = {'.git/'},
    languages = {
      typescript = {efm_formatters.prettier},
      javascript = {efm_formatters.prettier, efm_formatters.eslint},
      javascriptreact = {efm_formatters.eslint},
      typescriptreact = {efm_formatters.prettier},
      html = {}
    },
  },
})
