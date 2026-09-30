-- Finding and jumping: telescope and harpoon.
-- Browse the harpoon list through telescope rather than its own menu.
-- Declared at file scope so the `keys` table below stays a plain list: a
-- `keys = function()` that requires harpoon would load it during spec parsing,
-- defeating the lazy trigger.
local function harpoon_telescope()
	local harpoon_files = require("harpoon"):list()
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	local conf = require("telescope.config").values
	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({ results = file_paths }),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

local function harpoon_keys()
	local keys = {
		{ "<C-e>", harpoon_telescope, desc = "Open harpoon window" },
		{
			"<leader>aa",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Harpoon: add file",
		},
		{
			"<leader>ap",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Harpoon: previous file",
		},
		{
			"<leader>an",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Harpoon: next file",
		},
		{
			"<leader>ac",
			function()
				local list = require("harpoon"):list()
				for i = 1, 4 do
					list:remove_at(i)
				end
			end,
			desc = "Harpoon: clear list",
		},
	}

	-- <C-h/j/k/l> jump to slots 1-4, <leader><C-h/j/k/l> overwrite them
	for i, key in ipairs({ "h", "j", "k", "l" }) do
		table.insert(keys, {
			"<C-" .. key .. ">",
			function()
				require("harpoon"):list():select(i)
			end,
			desc = "Harpoon: go to file " .. i,
		})
		table.insert(keys, {
			"<leader><C-" .. key .. ">",
			function()
				require("harpoon"):list():replace_at(i)
			end,
			desc = "Harpoon: replace slot " .. i,
		})
	end

	return keys
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({})
			pcall(require("telescope").load_extension, "fzf")
		end,
		keys = {
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope: Find files",
			},
			{
				"<C-p>",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Telescope: Git files",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Telescope: Grep prompt",
			},
		},
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = harpoon_keys(),
	},
}
