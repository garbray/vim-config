-- Leader must be set before lazy.nvim reads any `keys =` spec.
vim.g.mapleader = " "

require("garbray.options")
require("garbray.keymaps")
require("garbray.lazy")
