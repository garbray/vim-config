let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
 \]

let g:startify_bookmarks = [
            \ {'i': '~/.config/nvim'},
            \ {'z': '~/.zshrc'},
            \ {'k': '~/.config/kitty'},
            \]

let g:startify_custom_header = [
            \' ________  ________  ________  ________  ________  ________      ___    ___  ',
            \'|\   ____\|\   __  \|\   __  \|\   __  \|\   __  \|\   __  \    |\  \  /  /|',
            \'\ \  \___|\ \  \|\  \ \  \|\  \ \  \|\ /\ \  \|\  \ \  \|\  \   \ \  \/  / / ',
            \' \ \  \  __\ \   __  \ \   _  _\ \   __  \ \   _  _\ \   __  \   \ \    / /  ',
            \'  \ \  \|\  \ \  \ \  \ \  \\  \\ \  \|\  \ \  \\  \\ \  \ \  \   \/  /  /   ',
            \'   \ \_______\ \__\ \__\ \__\\ _\\ \_______\ \__\\ _\\ \__\ \__\__/  / /      ',
            \'    \|_______|\|__|\|__|\|__|\|__|\|_______|\|__|\|__|\|__|\|__|\___/ /       ',
            \'                                                               \|___|/      ',
            \ ]

