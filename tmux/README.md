# TMUX

TMUX is a terminal multiplexer it will help you to stay in your terminal and have a presetup of your enviroment easilly

## Installation

```
brew install tmux
```

## Basic commands

Start a server

```
tmux
```

the most powerful way to use tmux is via the sessions, you can attach detach of your sessions and have process working in the background

Start a server with a prefix name

```
tmux new -s name
```

to detach from a tmux session you show run\

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>d</kbd>

detach from a list of sessions\

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>D</kbd>

when you want to goes back to a tmux session you run

```
tmux attach -t session-name
```

### commands inside a session

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>command</kbd>

tmux do this command

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>c</kbd>

create a new window

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>,</kbd>

rename the current window

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>p</kbd>

previous virtual

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>n</kbd>

next virtual

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>w</kbd>

list windows

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>%</kbd>

split vertical new window

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>s</kbd>

<!-- split horizontal new window -->

<!-- <kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>:</kbd> -->

let you introduce a command for more information goes to the docs

<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>:</kbd>

you will be able to type the command you want to execute
```
:resize-panel -x number%
```
resize the panel in a %

### other commands

```
tmux list-session
```

list all your sessions

```
tmux attach -t session-name
```

tmux reattach to a session

change between tmux sessions\
<kbd>ctrl</kbd> + <kbd>b</kbd> - <kbd>s</kbd>


## other resources

[tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
[tmux resources](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)
