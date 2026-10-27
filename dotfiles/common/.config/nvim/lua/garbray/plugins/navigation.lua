-- Jumping between marked files. Pickers live on the snacks spec in plugins/ui.lua.
return {
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
