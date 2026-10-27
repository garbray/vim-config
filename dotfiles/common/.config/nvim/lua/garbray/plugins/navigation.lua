-- File explorer and jumping between marked files. Pickers live on the snacks
-- spec in plugins/ui.lua.
return {
	{
		-- directories as editable buffers; replaces netrw, so `nvim .` opens it.
		-- Not lazy: it has to be loaded to take over directory buffers.
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = true,
			view_options = { show_hidden = true },
			keymaps = {
				-- <C-h>/<C-l> are harpoon slots 1 and 4; oil binds them to
				-- split and refresh by default
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
				["gR"] = "actions.refresh",
			},
		},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Oil: parent directory" },
			{ "<leader>pv", "<cmd>Oil<cr>", desc = "Oil: file explorer" },
		},
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = (function()
			local keys = {
				{
					"<C-e>",
					function()
						local harpoon = require("harpoon")
						-- harpoon's own menu: the list is an editable buffer, so
						-- entries can be reordered or removed by editing lines
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Open harpoon window",
				},
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
		end)(),
	},
}
