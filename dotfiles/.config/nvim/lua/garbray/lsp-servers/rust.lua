require'lspconfig'.rust_analyzer.setup{
--    cmd = {DATA_PATH .. "/lspinstall/rust/rust-analyzer"},
    on_attach = require'garbray.config'.common_on_attach
}

