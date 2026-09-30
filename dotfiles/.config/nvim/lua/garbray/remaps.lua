-- Global keymaps. Leader is set in garbray/init.lua.
-- Every map carries a `desc` so which-key can label it.

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw (file explorer)" })

map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Escape insert mode" })

-- window navigation
map("n", "<leader>h", "<C-W>h", { desc = "Window left" })
map("n", "<leader>j", "<C-W>j", { desc = "Window down" })
map("n", "<leader>k", "<C-W>k", { desc = "Window up" })
map("n", "<leader>l", "<C-W>l", { desc = "Window right" })

-- move the highlighted block up/down, re-indenting as it goes
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- join the line below without moving the cursor
map("n", "J", "mzJ`z", { desc = "Join line below (keep cursor)" })

-- keep the cursor centred while paging and searching
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centred)" })
map("n", "n", "nzzzv", { desc = "Next search result (centred)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centred)" })

-- paste over a selection without clobbering the unnamed register
map("x", "<leader>p", '"_dP', { desc = "Paste over selection (keep register)" })

-- system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- delete into the void register
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

map("n", "Q", "<nop>", { desc = "Disabled (was Ex mode)" })

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- quickfix list (see also <leader>Sq for the snacks picker)
map("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-b>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
	desc = "Substitute word under cursor",
})

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- tabs
map("n", "<leader>tc", vim.cmd.tabnew, { desc = "Tab: new" })
map("n", "<leader>tx", vim.cmd.tabclose, { desc = "Tab: close" })
map("n", "<leader>tp", vim.cmd.tabprevious, { desc = "Tab: previous" })
map("n", "<leader>tn", vim.cmd.tabnext, { desc = "Tab: next" })

-- splits
map("n", "<leader>vs", vim.cmd.vsplit, { desc = "Split vertically" })
map("n", "<leader>hs", vim.cmd.split, { desc = "Split horizontally" })

map("n", "<leader>bl", vim.cmd.buffers, { desc = "List buffers" })

-- copy current file path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy current file path to clipboard" })

map("n", "<leader>pp", ":Cppath<CR>", { desc = "Copy file path to clipboard" })
