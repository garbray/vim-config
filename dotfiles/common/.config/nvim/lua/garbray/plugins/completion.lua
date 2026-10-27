-- Completion engine and its sources.
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
