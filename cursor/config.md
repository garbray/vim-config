# Cursor / VSCode keybindings

to use the cursor keys in the terminal, you need to set the following keybindings in your VSCode settings:
- Open command palette (cnd + shift + p)
- Type "Preferences: Open Keyboard Shortcuts (JSON)"
- search for `vim.enable` this requires to have the vim extension installed
- update the settings.json with:

```json
{
    "window.commandCenter": 1,
    "workbench.settings.applyToAllProfiles": [
    ],
    "vim.leader": "<space>",
    "vim.enableNeovim": true,
    "vim.smartRelativeLine": true,
    "vim.normalModeKeyBindingsNonRecursive": [
        {
            "before": ["<C-p>"],
            "commands": ["workbench.action.quickOpen"]
        },
        {
            "before": ["g", "d"],
            "commands": ["editor.action.revealDefinition"]
          },
          {
            "before": ["g", "D"],
            "commands": ["editor.action.revealDeclaration"]
          },
          {
            "before": ["g", "r"],
            "commands": ["editor.action.referenceSearch.trigger"]
          },
          {
            "before": ["g", "i"],
            "commands": ["editor.action.goToImplementation"]
          },
          {
            "before": ["g", "y"],
            "commands": ["editor.action.goToTypeDefinition"]
          },
          {
            "before": ["<leader>", "t", "u"],
            "commands": ["workbench.action.terminal.toggleTerminal"]
          },
          {
            "before": ["<leader>", "t", "t"],
            "commands": ["workbench.action.terminal.toggleTerminal"]
          },
          {
            // Vertical split (to the right)
            "before": ["<leader>", "v", "s"],
            "commands": ["workbench.action.splitEditorRight"]
          },
          {
            // Horizontal split (below)
            "before": ["<leader>", "h", "s"],
            "commands": ["workbench.action.splitEditorDown"]
          },
          // navigate
          {
            "before": ["<leader>", "h"],
            "commands": ["workbench.action.focusLeftGroup"]
          },
          {
            "before": ["<leader>", "l"],
            "commands": ["workbench.action.focusRightGroup"]
          },
          {
            "before": ["<leader>", "k"],
            "commands": ["workbench.action.focusAboveGroup"]
          },
          {
            "before": ["<leader>", "j"],
            "commands": ["workbench.action.focusBelowGroup"]
          }
    ],
    "vim.commandLineModeKeyBindings": [

    ]
}```
