#!/bin/sh
session=$1

# set up tmux
tmux start-server

# create a new tmux session
tmux new-session -d -s $session

# name window as code
tmux rename-window code
# Split pane 1 horizontal by 75%,
tmux splitw -v -p 10
# start server
# tmux send-keys $2 C-m

# Select pane 2
#tmux selectp -t 2

# Split pane 2 vertiacally by 50%
# tmux splitw -h -p 50

# select pane 3, set to api root
#tmux selectp -t 3
# tmux send-keys "api" C-m

# Select pane 1
tmux selectp -U

# create tab for testing
tmux new-window
tmux rename-window TDD
tmux next-window

# enable mouse controls
# tmux set -g mouse on

# Finished setup, attach to the tmux session!
tmux send-keys -t $session 'nvim .' C-m
tmux attach-session -t $session
