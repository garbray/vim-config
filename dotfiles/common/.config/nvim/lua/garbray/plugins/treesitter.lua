-- Treesitter parsers plus the features built on them.
return {
	{
		-- main branch: the maintained rewrite. It only installs parsers and
		-- queries -- highlighting, indent and folds are core Neovim features that
		-- have to be switched on per buffer, which is what the autocmd below does.
		-- The old master branch shipped a markdown injections query using its own
		-- (#set-lang-from-info-string!) directive, which nvim 0.12 cannot parse.
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({})

			local langs = {
				"bash", "c", "c_sharp", "css", "diff", "go", "gomod", "gosum",
				"html", "javascript", "json", "lua", "luadoc",
				"markdown", "markdown_inline", "python", "query", "rust",
				"sql", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
			}

			local installed = {}
			for _, lang in ipairs(ts.get_installed("parsers")) do
				installed[lang] = true
			end
			local missing = vim.tbl_filter(function(lang)
				return not installed[lang]
			end, langs)
			if #missing > 0 then
				ts.install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("garbray-treesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang or not pcall(vim.treesitter.start, ev.buf, lang) then
						return
					end
					-- indent is nvim-treesitter's; highlighting above is core's
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{ "windwp/nvim-ts-autotag", opts = {} },
}
