" highlight ColorColumn ctermbg=0 guibg=grey
highlight Normal guibg=none
highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f

fun! SetTermGuiColors()
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif
endfun

fun! GruvboxTheme()
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_invert_selection='0'
    set background=dark
    colorscheme gruvbox
    hi! Normal ctermbg=NONE guibg=NONE
    call SetTermGuiColors()
endfun

fun! AyuTheme()
    let ayucolor="mirage"
    let g:indentLine_showFirstIndentLevel = 1
    let g:indentLine_setColors = 0
    colorscheme ayu
    let ayucolor="dark"
    highlight ColorColumn ctermbg=0 guibg=#21262d
    hi! Normal ctermbg=NONE guibg=NONE
    hi netrwDir guifg=#5eacd3
    highlight lineNr guifg=#d35e5e
    " remove underline on ayutheme
    hi! MatchParen gui=NONE cterm=NONE term=NONE
endfun

"set default gruvbox
call GruvboxTheme()

nnoremap <leader>co :call AyuTheme()<CR>
nnoremap <leader>cg :call GruvboxTheme()<CR>

