-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
-- local term = require("harpoon.term")

-- v2
local harpoon = require("harpoon")

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

-- vim.keymap.set("n", "<C-e>", function()
-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
-- end)
vim.keymap.set("n", "<C-e>", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>ap", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>an", function()
	harpoon:list():next()
end)

-- vim.keymap.set("n", "<leader>aa", mark.add_file)
-- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>ac", function()
	harpoon:list():remove_at(1)
	harpoon:list():remove_at(2)
	harpoon:list():remove_at(3)
	harpoon:list():remove_at(4)
end)

vim.keymap.set("n", "<leader><C-h>", function()
	harpoon:list():replace_at(1)
end)
vim.keymap.set("n", "<leader><C-j>", function()
	harpoon:list():replace_at(2)
end)
vim.keymap.set("n", "<leader><C-k>", function()
	harpoon:list():replace_at(3)
end)
vim.keymap.set("n", "<leader><C-l>", function()
	harpoon:list():replace_at(4)
end)
