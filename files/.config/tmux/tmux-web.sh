#!/bin/sh
session=$1

# set up tmux
tmux start-server

# create a new tmux session
tmux new-session -d -s $session

# Split pane 1 horizontal by 75%,
tmux splitw -v -p 10
# start server
# tmux send-keys $2 C-m

# Select pane 2
#tmux selectp -t 2

# Split pane 2 vertiacally by 50%
tmux splitw -h -p 50

# select pane 3, set to api root
#tmux selectp -t 3
# tmux send-keys "api" C-m

# Select pane 1
tmux selectp -U

# enable mouse controls
# tmux set -g mouse on

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
