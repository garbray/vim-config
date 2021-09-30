let g:closetag_filenames = "*.html,*.jsx,*.tsx,*.vue,*.xhml,*.xml"
let g:closetag_regions = {
  \ 'typescript.tsx': 'jsxRegion,tsxRegion',
  \ 'javascript.jsx': 'jsxRegion',
  \ }

let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
" let g:closetag_close_shortcut = '<leader>>'
