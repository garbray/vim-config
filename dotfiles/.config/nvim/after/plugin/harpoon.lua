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

vim.keymap.set("n", "<C-e>", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>aa", function()
	harpoon:list():add()
end, { desc = "Harpoon: add file" })

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end, { desc = "Harpoon: go to file 1" })
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(2)
end, { desc = "Harpoon: go to file 2" })
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(3)
end, { desc = "Harpoon: go to file 3" })
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(4)
end, { desc = "Harpoon: go to file 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>ap", function()
	harpoon:list():prev()
end, { desc = "Harpoon: previous file" })
vim.keymap.set("n", "<leader>an", function()
	harpoon:list():next()
end, { desc = "Harpoon: next file" })

vim.keymap.set("n", "<leader>ac", function()
	harpoon:list():remove_at(1)
	harpoon:list():remove_at(2)
	harpoon:list():remove_at(3)
	harpoon:list():remove_at(4)
end, { desc = "Harpoon: clear list" })

vim.keymap.set("n", "<leader><C-h>", function()
	harpoon:list():replace_at(1)
end, { desc = "Harpoon: replace slot 1" })
vim.keymap.set("n", "<leader><C-j>", function()
	harpoon:list():replace_at(2)
end, { desc = "Harpoon: replace slot 2" })
vim.keymap.set("n", "<leader><C-k>", function()
	harpoon:list():replace_at(3)
end, { desc = "Harpoon: replace slot 3" })
vim.keymap.set("n", "<leader><C-l>", function()
	harpoon:list():replace_at(4)
end, { desc = "Harpoon: replace slot 4" })
