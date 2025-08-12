-- vim  TODO pluggin
local keymap = vim.keymap

keymap.set("n", "<leader>bt", ":Todo<CR>", { desc = "Bujo Toggle Todo" })
keymap.set("n", "<leader>bc", "<Plug>BujoChecknormal", { desc = "Bujo check Todo" })
keymap.set("n", "<leader>ba", "<Plug>BujoAddnormal", { desc = "Add Todo" })
vim.g["g#todo_file_path"] = '$HOME . "/.cache/bujo"'
