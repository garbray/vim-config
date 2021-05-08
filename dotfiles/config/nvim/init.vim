set path+=**
set encoding=utf8

call plug#begin('~/.vim/plugged')
" lsp neovim
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'kabouzeid/nvim-lspinstall'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'
" language
Plug 'rust-lang/rust.vim'
Plug 'tweekmonster/gofmt.vim'
Plug 'jparise/vim-graphql'
" colorschema
Plug 'gruvbox-community/gruvbox'
Plug 'ayu-theme/ayu-vim'
" errors for lsp
Plug 'folke/lsp-colors.nvim'
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
" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
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
" Plug 'preservim/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'vim-utils/vim-man'
Plug 'vuciv/vim-bujo'
" last loaded
" Plug 'ryanoasis/vim-devicons'
" worktree
Plug 'ThePrimeagen/git-worktree.nvim'
" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

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
nnoremap <leader>vn :cn<CR>
nnoremap <leader>vp :cp<CR>
" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" spell checker
set spelllang=en_us
nnoremap <leader>sc :set spell!<cr>

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
