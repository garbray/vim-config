# Nvim Improvements Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Fix broken diagnostic shortcuts, add proper TS/React intellisense via vtsls, and apply general polish.

**Architecture:** Targeted edits to 5 existing Lua config files. No new plugin infrastructure — vtsls swaps in place of ts_ls via the existing mason-lspconfig + lspconfig pattern already in use.

**Tech Stack:** Neovim, Lua, lazy.nvim, mason.nvim, nvim-lspconfig, blink.cmp, conform.nvim, nvim-treesitter

**Design doc:** `docs/plans/2026-02-24-nvim-improvements-design.md`

---

### Task 1: Fix diagnostic jump shortcuts

**Files:**
- Modify: `dotfiles/.config/nvim/lua/garbray/plugins/lsp.lua:107-114`

**Step 1: Open lsp.lua and locate the diagnostic keymaps**

Find lines 107–114. They currently look like:
```lua
-- keymap("n", "<leader>gn", diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
-- keymap("n", "<leader>gp", diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })
keymap("n", "<leader>gn", function()
    diagnostic.jump({ count = 1 })
end, { buffer = bufnr, desc = "Go to next diagnostic" })
keymap("n", "<leader>gp", function()
    diagnostic.jump({ count = -1 })
end, { buffer = bufnr, desc = "Go to previous diagnostic" })
```

**Step 2: Replace with backward-compatible API**

Replace lines 107–114 with:
```lua
keymap("n", "<leader>gn", function()
    vim.diagnostic.goto_next({ float = true })
end, { buffer = bufnr, desc = "Go to next diagnostic" })
keymap("n", "<leader>gp", function()
    vim.diagnostic.goto_prev({ float = true })
end, { buffer = bufnr, desc = "Go to prev diagnostic" })
```

Note: Remove the two commented-out lines above as well (they're now replaced).

**Step 3: Verify**

Open any file with a diagnostic error in nvim. Press `<leader>gn`. Cursor should jump to the next diagnostic AND a float popup should appear showing the error message.

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/lua/garbray/plugins/lsp.lua
git commit -m "fix(nvim): use goto_next/prev for diagnostics, add float"
```

---

### Task 2: Swap ts_ls → vtsls in mason-lspconfig

**Files:**
- Modify: `dotfiles/.config/nvim/lua/garbray/plugins/lsp.lua:29`

**Step 1: Update ensure_installed**

In `mason-lspconfig` `ensure_installed` list (around line 27–45), change:
```lua
"ts_ls",
```
to:
```lua
"vtsls",
```

**Step 2: Verify**

No runtime check needed yet — mason will install vtsls on next nvim start. Proceed to Task 3.

---

### Task 3: Replace ts_ls lspconfig block with vtsls

**Files:**
- Modify: `dotfiles/.config/nvim/lua/garbray/plugins/lsp.lua:144-148`

**Step 1: Find the ts_ls setup block**

Lines 144–148 currently:
```lua
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "javascript", "typescript", "vue", "tsx", "jsx" },
})
```

**Step 2: Replace with vtsls block**

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

**Step 3: Verify**

Open nvim. Run `:Mason`, find vtsls, install it (or let mason auto-install). Then open a `.tsx` file. Run `:LspInfo` — you should see `vtsls` attached to the buffer. Autocomplete and hover (`K`) should work.

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/lua/garbray/plugins/lsp.lua
git commit -m "feat(nvim): switch ts_ls to vtsls for better TS/React intellisense"
```

---

### Task 4: Add tsx to treesitter ensure_installed

**Files:**
- Modify: `dotfiles/.config/nvim/after/plugin/treesitter.lua:2`

**Step 1: Find ensure_installed**

Line 2 currently:
```lua
ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "html", "vim", "markdown" },
```

**Step 2: Add tsx**

```lua
ensure_installed = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "c", "lua", "rust", "html", "vim", "markdown" },
```

Note: `tsx` is the treesitter grammar name. `typescriptreact`/`javascriptreact` may or may not be separate grammars — include them for completeness, treesitter will skip any that don't exist.

**Step 3: Verify**

Open nvim, run `:TSInstall tsx`. Then open a `.tsx` file — syntax highlighting should work correctly including JSX tags.

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/after/plugin/treesitter.lua
git commit -m "fix(nvim): add tsx to treesitter ensure_installed"
```

---

### Task 5: Enable telescope-fzf-native

**Files:**
- Modify: `dotfiles/.config/nvim/lua/garbray/plugins/core.lua:83`

**Step 1: Find the commented plugin**

Line 83 currently:
```lua
--{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
```

**Step 2: Uncomment it**

```lua
{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
```

**Step 3: Verify**

Open nvim — lazy.nvim will detect the new plugin and prompt install. Run `:Lazy sync`. After install, telescope fuzzy search (`<leader>pf` or similar) should feel noticeably faster on large directories.

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/lua/garbray/plugins/core.lua
git commit -m "perf(nvim): enable telescope-fzf-native"
```

---

### Task 6: Remove redundant format_after_save

**Files:**
- Modify: `dotfiles/.config/nvim/after/plugin/conform.lua:37-39`

**Step 1: Find format_after_save**

Lines 37–39 currently:
```lua
format_after_save = {
    lsp_format = "fallback",
},
```

**Step 2: Delete the block**

Remove those 3 lines entirely. `format_on_save` alone is sufficient and avoids double formatting.

**Step 3: Verify**

Save a TypeScript file in nvim. It should format once (not twice — you'd notice double formatting as a flicker or duplicate edits).

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/after/plugin/conform.lua
git commit -m "fix(nvim): remove redundant format_after_save"
```

---

### Task 7: Fix conceallevel setting

**Files:**
- Modify: `dotfiles/.config/nvim/lua/garbray/set.lua:43`

**Step 1: Find the broken line**

Line 43 currently:
```lua
vim.conceallevel = 1
```

**Step 2: Fix it**

```lua
vim.opt.conceallevel = 1
```

**Step 3: Verify**

Open a markdown file in nvim. Bold/italic markers and link syntax should be concealed (rendered, not shown as raw `**` or `[]`).

**Step 4: Commit**

```bash
git add dotfiles/.config/nvim/lua/garbray/set.lua
git commit -m "fix(nvim): fix conceallevel opt assignment"
```

---

## Unresolved Questions

None — all design decisions were approved before writing this plan.
