# VIM

- vim as lightweight IDE
- persistent session management using tmux
- efficient workflow navigation using hotkeys
- how to get rid of your mouse

## MODES

Vim have four major modes

> NORMAL mode -> esc

allows you to only watch a file

> INSERT mode -> i, a, c

allows you to type inside a file

> VISUAL Mode -> v, V, ctrl v

allows you highlight text

> COMMANDS Mode -> :, /

allows you run commands inside your vim

## KEY TERMS

Vim use the vi naming convention it means every operation you can perform is associated to a word

> i = inset
> a = append
> c = change

at vim you should think on operators, text objects and motions

## Operators

<kbd>d</kbd> delete\
<kbd>y</kbd> yank into the register\
<kbd>~</kbd> swap case\
<kbd>gu</kbd> make lowercase\
<kbd>gU</kbd> make uppercase\
<kbd>!</kbd> filter to external program\
<kbd> \ </kbd> shift left\
<kbd> \ </kbd> shift right\
<kbd>=</kbd> indent

## text objects

<kbd>aw</kbd> a word\
<kbd>iw</kbd> inner word\
<kbd>aW</kbd> a WORD\
<kbd>iW</kbd> inner WORD\
<kbd>ap</kbd> a paragraph\
<kbd>ip</kbd> inner paragraph\
<kbd>ab</kbd> a bracket\
<kbd>ib</kbd> inner bracket\
<kbd>at</kbd> a tag block\
<kbd>it</kbd> inner tag block

## motions

<kbd>%</kbd> => go to first matching parent / bracket
[count]+ => down to first non blank char of line

<kbd>*</kbd> => find and go to the next word you are over\
<kbd>#</kbd> => find and go to the previous word you are over\
<kbd>a</kbd><kbd>w</kbd> => a word

create a new file

<kbd>v</kbd> <kbd>s</kbd> <kbd>p</kbd> filename -> creates a new file in a new split window and will saved after :w\

## PUTTING IT ALL TOGETHER

[COUNT][operator][text object / motion]
6+ = 6x go down to line start
gUaW = capitalize a word
3ce = 3x change to word end
4\$ = 4x go to end of line
d]m = delete to start of next method
% = jump to match of next parent or bracket

## NAVIGATION

H => high of the screen
M => middle of the screen
L => low of the screen
ctrl+u => up one page
ctrl+d => down one page

zt -> cursor position to top
zz -> cursor position to middle
zb -> cursor position to bottom

gx ->open in a new tab a link under the cursor

don't relay on arrow keys use hjkl
b => go back to the previous word
w => go to the init on the next line
f = jump to the letter you press
t = jump one be for the letter you press
% = jump between brackets, curly brackets, or square brackets

v visual mode select
shift+v line visual mode select all the line

ctrl+u jump half page up
ctrl+d jump half page down

p = paste next line
shift+p = paste up
shift U capitalize your selected text

ctrl a = jump to a number and increment in 1
ctrl x = jump to a number and decrement in 1

o => new line bellow
shift+o = new line before

shift+a = last line and place you in insert mode

shift+i = place you in front of the current line in insert mode
shift+[ = place you in the previous empty space
shift+] = place you in the next empty space

ctrl+[ = escape of insert mode
; next find character
, prev find character

dw delete word
control i auto complete
cw = mix together the two previous commands
i,a = insert after
vi( select inside the group
va(
di{ delete inside {

mark a pointer of code you can jump in
useful to jump between files
m+shift+j create the mark you will jump
shift j jump to the marked

control o = previous file
control i = undo previous file
shift k move up
shift j move down

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

gv re highlight previous
"\*y = copy into the clipboard the selected tex

ctrl+z = return into terminal and run vim in background
fg = goes back to background vim

/pattern -> find word

then press n to find the next match

## COMMANDS

:windo difft -> show the difference between windows

:e! => edit
:fin => find

## MARKS

The bookmarks of vi

m{a-zA-Z} sets a custom mark whose exact location can be accessed using \`{mark} and line accessed using \`{mark}
:marks shows all the curent marks that are being used

certain marks are special. For example, the special marks \`. used for jumping to the last change

## tags

ctrl-]
ctrl-O
ctrl-I cycle through :jumps
g; / g, cycle through :changes

## project management in vim

tabs for window containers,
windows for buffer viewports,
buffors for file proxies (and the arglist)

### buffers

:bn -> go to next buffer
:b {filename} go to buffer filename
:bd -> delete current buffer
:buffers -> print out all buffers
:bufdo {cmd} -> execute {cmd} for all buffers
:n go to next fine based on arg list
:arga {filename} add filename to arg list
:argl {files} -> make a local arg copy via {files}
:args -> print out all arguments

args -> the loading files
buffer -> files you open but are not in the initial context of vim

specity argument list
:args \*_\/_.js
sall -> split all files in the args
vertical split all
vert all

### windows

ctrl-w s -> split window
ctrl-w v -> split window vertically
ctrl-w q -> close window
ctrl-w w -> alternate window
ctrl-w r -> rotate window
:windo cmd -> execute cmd for all windows
:sf {FILE} -> split window and :find {FILE}
:vert cmd -> make any split {cmd} be vertical

:windo difft

### tags

those are created by separed windows collections not files

gt -> go to next tab
gT -> go to prev tab
:tabc -> close tab
:tabe -> close tab
:tabo -> close all other tabs

## clipboard synchronization

osc52

### review registers

### searching on a project

to search all over a project you will need to:

:vimgrep /JFactory/ `**/*.js`
use vimgrep regex to find and the path where you want to search
Warning: :vimgrep will trigger autocmds if enabled. This can slow down the search. If you don't want that you can do:
:noautocmd vimgrep

Once the command of your choice returned, you can browse the search results with those commands described in the Vim documentation at :help quickfix. Lookup :cfirst, :cnext, :cprevious, :cnfile, etc.

## markdown

conceal is a way to show the final product of your markdown files to enable or disable use
:let conceallevel=0 -> disable
:let conceallevel=1 -> enable

```
Galooshi/vim-import-js
review on git for import files
```
