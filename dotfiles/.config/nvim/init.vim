set path+=**
set encoding=utf8

call plug#begin('~/.vim/plugged')
if has("nvim")
  " lsp neovim
  Plug 'neovim/nvim-lspconfig'
  " Plug 'tjdevries/nlua.nvim'
  " no super sure if this is necessary we will see
  " Plug 'tjdevries/lsp_extensions.nvim'
  Plug 'williamboman/nvim-lsp-installer' " simple to use language server installer
" until the probem for code action on lspsaga been resolve
  " Plug 'glepnir/lspsaga.nvim'
  Plug 'rinx/lspsaga.nvim'

  " autocomplete
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'tamago324/nlsp-settings.nvim' " language server settings defined in json for
  Plug 'jose-elias-alvarez/null-ls.nvim' " for formatters and linters

  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " For luasnip users.
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets'

  " Neovim Tree shitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'p00f/nvim-ts-rainbow'
  " telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  " try IA code
endif

" language
Plug 'rust-lang/rust.vim'
Plug 'tweekmonster/gofmt.vim'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
" colorschema
Plug 'gruvbox-community/gruvbox'
Plug 'ayu-theme/ayu-vim'
" utility
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
" auto pairs
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
" indentation
Plug 'Yggdroot/indentLine'
" adjust tabsize
Plug 'tpope/vim-sleuth'
" json with comments
Plug 'kevinoid/vim-jsonc'
" project management
Plug 'mhinz/vim-startify'
" dash
Plug 'rizzatti/dash.vim'
" align items and markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" adjust tabsize
Plug 'tpope/vim-sleuth'
Plug 'unblevable/quick-scope'

Plug 'hoob3rt/lualine.nvim'
" possible deprecations in future
" float search
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'vim-utils/vim-man'
Plug 'vuciv/vim-bujo'
" worktree
Plug 'ThePrimeagen/git-worktree.nvim'
" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" last loaded
" Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'ThePrimeagen/harpoon'
call plug#end()
" require lua config
lua require("garbray")

" Replace all is aliases to S
nnoremap S :%s//g<left><left>
"remap basic movements
let mapleader = " "
inoremap jk <ESC>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
" nnoremap <Leader>cpu a%" PRIu64 "<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" tabs
nnoremap <leader>tc :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tn :tabnext<CR>
" buffers
nnoremap <Leader>bl :buffers<CR>:buffer<Space>

" c jumps
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>
" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" spell checker
set spelllang=en_us
nnoremap <leader>sc :set spell!<cr>

" vim TODO
nnoremap <Leader>tt :Todo<CR>
nmap <Leader>ct <Plug>BujoChecknormal
nmap <Leader>at <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_P
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    " autocmd VimEnter * :VimApm
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

" open url under cursor in your browser
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
