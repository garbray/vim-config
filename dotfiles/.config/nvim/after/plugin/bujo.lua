-- vim  TODO pluggin
local keymap = vim.keymap

keymap.set("n", "<leader>tt", ":Todo<CR>")
keymap.set("n", "<leader>ct", "<Plug>BujoChecknormal")
keymap.set("n", "<leader>at", "<Plug>BujoAddnormal")
vim.g["g#todo_file_path"] = '$HOME . "/.cache/bujo"'
