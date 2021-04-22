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
    formatCommand = 'prettier --write --stdin-filepath ${INPUT}',
    formatStdin = true,
    -- rootMarkers = {'package.json',  '.git/'},
  },
  eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
  },
  flake8 = {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
  },
  black = {
    formatCommand = "black --quiet -",
    formatStdin = true
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

-- npm install -g eslint_d
nvim_lsp.efm.setup({
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern('package.json', 'tsconfig.json', '.git'),
  cmd = {'efm-langserver', '-logfile', '/tmp/efm.log', '-loglevel', '5'},
  init_options = {
    documentFormatting = true,
  },
  capabilities = capabilities,
  filetypes = {
    "javascript.jsx",
    "javascriptreact",
    "javascript",
    "typescriptreact",
    "typescript.tsx",
    "typescript",
    "html",
    "css",
    "json",
    "yaml",
    "python",
  },
  settings = {
    rootMarkers = {'.git/'},
    languages = {
      typescript = {efm_formatters.prettier},
      javascript = {efm_formatters.prettier, efm_formatters.eslint},
      -- javascript = { efm_formatters.eslint},
      javascriptreact = {efm_formatters.eslint},
      typescriptreact = {efm_formatters.prettier},
      html = {efm_formatters.prettier},
      css = {efm_formatters.prettier},
      json = {efm_formatters.prettier},
      yaml = {efm_formatters.prettier},
      python = {efm_formatters.flake8, efm_formatters.black}
    },
  },
})

