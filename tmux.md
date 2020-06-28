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

to detach from a tmux session you show run

> ctrl + b - d

detach from a list of sessions

> ctrl + b - D

when you want to goes back to a tmux session you run

```
tmux attach -t session-name
```

### commands inside a session

> ctrl + b - <command>

tmux do this command

> ctrl + b - c

create a new window

> ctrl + b - ,

rename the current window

> ctrl + b - p

previous virtual

> ctrl + b - n

next virtual

> ctrl + b - w

list windows

> ctrl + b - %

split vertical new window

> ctrl + b - s

split horizontal new window

> ctrl + b - :<command>

let you introduce a command for more information goes to the docs

> ctrl + b - :resize-pane -x number%

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

## other resources

[tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
[tmux resources](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)
