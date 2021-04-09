" highlight ColorColumn ctermbg=0 guibg=grey
highlight Normal guibg=none
highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox

" set background=light    " for light version of theme
" let g:ayucolor="mirage" " for mirage version of theme
" set background=dark     " for either mirage or dark version.
" let g:ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" colorscheme dracula"
" let g:dracula_bold = 1
" let g:dracula_italic = 1
" let g:dracula_colorterm = 1
