# Nvim Improvements Design

Date: 2026-02-24

## Problem Statement

Three issues in the current nvim config:
1. Diagnostic jump shortcuts (`<leader>gn` / `<leader>gp`) completely non-functional
2. No autocomplete or intellisense hints in TypeScript/React (`.tsx`, `.jsx`) files
3. Minor polish: double formatting on save, telescope perf, conceallevel bug

## Root Causes

- `vim.diagnostic.jump()` only exists in Neovim 0.11+; silently does nothing on 0.10.x
- `ts_ls` filetypes configured as `"tsx"/"jsx"` but Neovim's actual filetype names are `"typescriptreact"/"javascriptreact"` — LSP never attaches to those files
- Both `format_on_save` and `format_after_save` set in conform.lua — formats twice per save
- `telescope-fzf-native` commented out — slower fuzzy search
- `vim.conceallevel = 1` missing `opt.` — silently does nothing

## Design

### 1. Diagnostic Shortcuts

Replace `vim.diagnostic.jump()` with universally-supported API. Add `float = true` so error description shows on landing.

```lua
keymap("n", "<leader>gn", function()
    vim.diagnostic.goto_next({ float = true })
end, { buffer = bufnr, desc = "Go to next diagnostic" })

keymap("n", "<leader>gp", function()
    vim.diagnostic.goto_prev({ float = true })
end, { buffer = bufnr, desc = "Go to prev diagnostic" })
```

### 2. Switch ts_ls → vtsls

`vtsls` is VS Code's TypeScript language server. Better auto-imports, proper JSX/TSX support, inlay hints, faster than `ts_ls`.

- In `mason-lspconfig` ensure_installed: `"ts_ls"` → `"vtsls"`
- Replace `ts_ls` lspconfig block with `vtsls`:

```lua
lspconfig.vtsls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings = {
        typescript = {
            inlayHints = {
                parameterNames = { enabled = "literals" },
                variableTypes = { enabled = true },
                returnTypes = { enabled = true },
            },
        },
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
        },
    },
})
```

- Add `"tsx"` to treesitter `ensure_installed`

### 3. General Polish

- Uncomment `telescope-fzf-native` in `core.lua`
- Remove `format_after_save` block from `conform.lua`
- Fix `vim.conceallevel = 1` → `vim.opt.conceallevel = 1` in `set.lua`

## Files to Change

| File | Change |
|------|--------|
| `lua/garbray/plugins/lsp.lua` | Fix diagnostic keymaps, swap ts_ls→vtsls in mason + lspconfig |
| `after/plugin/treesitter.lua` | Add `"tsx"` to ensure_installed |
| `lua/garbray/plugins/core.lua` | Uncomment telescope-fzf-native |
| `after/plugin/conform.lua` | Remove format_after_save block |
| `lua/garbray/set.lua` | Fix conceallevel |
