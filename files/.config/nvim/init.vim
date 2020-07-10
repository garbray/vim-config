syntax on

set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set showmatch
"set noshowmatch
" Give more space for displaying messages.
"set cmdheight=2

" Highlight search matches can be noise review it
"set hlsearch
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" autopairs
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
"tmux plugin
Plug 'christoomey/vim-tmux-navigator'
" nerdthree
Plug 'preservim/nerdtree'
Plug 'ap/vim-css-color'
" indentation
Plug 'Yggdroot/indentLine'
" styled componets
"Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" themes
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim'
" TS highlight
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
" markdown
Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
" commentary
Plug 'tpope/vim-commentary'
" adjust tabsize
Plug 'tpope/vim-sleuth'
"
Plug 'tpope/vim-surround'
" vim todo
Plug 'vuciv/vim-bujo'

call plug#end()

let g:yats_host_keyword = 1
" disable folding markdown
" let g:vim_markdown_folding_disabled = 1
" --- The Greatest plugin of all time.  I am not bias
 let g:vim_be_good_floating = 1

"""""""""""""""" TYPESCRIPT """""""""""""""""""""""""""""""""

"typescript
let g:typescript_indent_disable = 1
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
"setlocal indentkeys+=0

"""""""""""""""" NERDTREE """""""""""""""""""""""""""""""""

let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
"open nerdtree automatically
map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""" FIND FILES FZF """""""""""""""""""""""

" Requires ripgrep
" https://github.com/BurntSushi/ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

if has('win32')
  " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = ''
else
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
 endif

nmap // :BLines!<CR>
nmap ?? :Rg!<CR>

""""""""""""""""" COLOR SCHEME SETUP """""""""""""""""""""""

" airline theme config
let g:lightline = {}
let g:airline_theme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

"""""""""""""""""""""""""""""""""""""

let g:indentLine_setColors = 0

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

" when open a new file opens in a vertical split
"let g:netrw_browse_split = 2
let g:netrw_browse_split = 0

let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""""""""" COMMENTARY CONFIG """""""""""""""""""""

" toggle commenting of lines with command + /
nmap <leader>/ :Commentary<CR>
vmap <leader>/ :Commentary<CR>

"""""""""" COC CONFIG """""""""""""""""""""

let g:coc_global_extensions = [
      \'coc-snippets',
      \'coc-pairs',
      \'coc-tsserver',
      \'coc-eslint',
      \'coc-prettier',
      \'coc-json',
      \]

" GoTo code navigation
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

xmap <silent> <leader>a :<C-u>execute 'CocCommand action.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

"imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<tab>'

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" use space to trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"""""""""" PRETTIER CONFIG """"""""""""""""""""

" prettier command for coc
"command! -nargs=0 Prettier :CocCommand prettier.formatFile <bar> :CocCommand eslint.executeAutofix <CR>
" run prettier on save
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

"""""""""" MAP KEYS """""""""""""""""""""

inoremap jk <ESC>
inoremap <C-c> <esc>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>sv :wincmd v<CR>

vnoremap X "_d

"copy to user clipboard selected
vmap <Leader>y "*y<CR>

""""""""" VIM TODO """""""""""""""""""""

nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

"""""""""" fugitive """""""""""""""""""""

nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

let g:loaded_matchparen=1
" conceallevel set to fold markdown
set conceallevel=0
let g:airline#extensions#tabline#enabled = 1

"augroup highlight_yank
"    autocmd!
"    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
"augroup END
