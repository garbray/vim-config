-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require('garbray.lsp.lsp-installer')
require('garbray.lsp.handlers').setup()
require "garbray.lsp.null-ls"

require('garbray.lsp.settings.bash')
require('garbray.lsp.settings.css')
require("garbray.lsp.settings.efm")
require('garbray.lsp.settings.emmet')
require('garbray.lsp.settings.go')
require('garbray.lsp.settings.graphql')
require('garbray.lsp.settings.html')
require('garbray.lsp.settings.python')
require('garbray.lsp.settings.rust')
require('garbray.lsp.settings.terraform')
require('garbray.lsp.settings.ts')
require('garbray.lsp.settings.vim')
require('garbray.lsp.settings.yaml')
