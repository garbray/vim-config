:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false
    }
  }
EOF
