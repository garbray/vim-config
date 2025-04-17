local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "eslint_d" },
		typescript = { "prettierd", "eslint_d" },
		javascriptreact = { "prettierd", "eslint_d" },
		typescriptreact = { "prettierd", "eslint_d" },
		go = { "goimports", "gofmt", "golines" },
		-- You can also specify a formatter for a specific file
		["*.json"] = { "jq" },
		html = { "prettier" },
		css = { "prettier" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_format = "fallback",
	},
	notify_on_error = true,
	-- Conform will notify you when no formatters are available for the buffer
	notify_no_formatters = true,
	formatters = {
		my_formatter = {
			-- A function that calculates the directory to run the command in
			cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
		},
	},
})
