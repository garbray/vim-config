-- new keymaps
-- local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Sex)
local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jk", "<ESC>", opts)

-- navigation remap
vim.keymap.set("n", "<leader>h", "<C-W>h")
vim.keymap.set("n", "<leader>j", "<C-W>j")
vim.keymap.set("n", "<leader>k", "<C-W>k")
vim.keymap.set("n", "<leader>l", "<C-W>l")

-- move on highlight
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move current line but maintain current focus
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle when use Ctrl d / u vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when search for a word keep the cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- highlight a text and past over without loosing your current register
-- using the void register
vim.keymap.set("x", "<leader>p", '"_dP')

-- copy on your system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
-- ignore capital Q
vim.keymap.set("n", "Q", "<nop>")
-- jump to another tmux session
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

-- quick fix list
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-b>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- TODO add a quickfix list into a telescope

-- search and replace the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make executable the current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- tabs
vim.keymap.set("n", "<leader>tc", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>tp", vim.cmd.tabprevious)
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnext)

-- splits
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

-- list buffers
-- nnoremap <Leader>bl :buffers<CR>:buffer<Space>
vim.keymap.set("n", "<leader>bl", vim.cmd.buffers)

-- source vim config
vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
