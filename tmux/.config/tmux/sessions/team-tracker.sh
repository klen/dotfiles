cd ~/projects/team-tracker

tmux rename-window common

tmux new-window -n api -c ~/projects/team-tracker/api
tmux new-window -n web -c ~/projects/team-tracker/web
tmux new-window -n devops -c ~/projects/team-tracker/devops

tmux select-window -t "$s:common"
