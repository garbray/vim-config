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

vim.opt.guifont = "FiraCode Nerd Font:h11"
-- mode is shown by lualine/noice
vim.opt.showmode = false
vim.opt.conceallevel = 1

-- vim.opt.encoding = "uft-8"
