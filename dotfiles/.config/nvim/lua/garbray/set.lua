vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- undotree config
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Performance optimizations
-- vim.opt.lazyredraw = true
-- vim.opt.ttyfast = true

vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true

vim.g.mapleader = " "
vim.opt.guifont = "Hack_Nerd_Font:h11"
vim.g.noshowmode = false
vim.opt.conceallevel = 1

-- netrw
-- Netrw banner
-- 0 : Disable banner
-- 1 : Enable banner
vim.g.netrw_banner = 0
-- didn't like the tree view :(
-- vim.g.netrw_liststyle = 3
-- Patterns for hiding files, e.g. node_modules
-- NOTE: this works by reading '.gitignore' file
-- vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()

-- vim.opt.encoding = "uft-8"
