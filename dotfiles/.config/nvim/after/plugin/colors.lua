function ColorMyPencils(color)
	-- color = color or "rose-pine"
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "none", bg = "#21262d" })
	vim.api.nvim_exec(
		[[
			hi! Normal ctermbg=NONE guibg=NONE
			" highlight ColorColumn ctermbg=0 guibg=grey
			highlight Normal guibg=none
			" highlight LineNr guifg=#5eacd3
			highlight lineNr guifg=#d35e5e
			highlight netrwDir guifg=#5eacd3
			highlight qfFileName guifg=#aed75f
			set termguicolors
		]],
		false
	)
end

function ColorGruvbox(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)
	vim.api.nvim_exec(
		[[
			let g:gruvbox_contrast_dark = 'hard'
			let g:gruvbox_invert_selection='0'
			set background=dark
			hi! Normal ctermbg=NONE guibg=NONE
			" highlight ColorColumn ctermbg=0 guibg=grey
			highlight Normal guibg=none
			" highlight LineNr guifg=#5eacd3
			highlight lineNr guifg=#d35e5e
			highlight netrwDir guifg=#5eacd3
			highlight qfFileName guifg=#aed75f
		]],
		false
	)
end

vim.keymap.set("n", "<leader>cp", function()
	ColorMyPencils("rose-pine")
end)

vim.keymap.set("n", "<leader>co", function()
	ColorMyPencils("catppuccin")
end)

-- default catppuccin
ColorMyPencils("rose-pine")
