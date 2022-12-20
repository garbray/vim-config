require'nvim-treesitter.configs'.setup {
  ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust" },
  sync_install = false,
  auto_install = true,
  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- nvim-ts-autotag
  autotag = {
      enable = true,
  }
}


-- auto pairs complete
require("nvim-autopairs").setup {}
