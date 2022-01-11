local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader keymap
keymap("", "<space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jk", "<ESC>", opts)

-- TODO transfer keymaps to here and install global vim
