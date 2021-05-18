
require("garbray.lsp")
-- require("garbray.lsp-server.efm")
-- require("garbray.lsp-server.lsp-install")
require("garbray.treesitter")
require("garbray.statusline")
require("garbray.completion")
require("garbray.telescope")
require("garbray.git-worktree")
require("garbray.harpoon")

-- color schema error fallback
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

