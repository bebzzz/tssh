#!/bin/bash
# usage
if [[ ! -n "$1" ]]
then
    echo "Usage: $0 <host1> <host2> ...or env-class-{1..i}"
    exit 1
fi

# random session name
session=manyhosts

# get hosts
host=("$@")

# start session and 1st connection
echo $session
tmux -2 new-session -d -s $session "ssh ${host[0]}"


for (( i=1 ; i < ${#host[@]} ; i++))
do
  tmux splitw -t $session "ssh ${host[$i]}"
  tmux select-layout tiled
done

tmux set-window-option synchronize-panes on
tmux attach -t $session

