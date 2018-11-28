tmux new -s pan -d
tmux new-window

tmux send-keys -t pan:0 'elixir --sname node2 -S mix test --only distr2_test' C-m
tmux send-keys -t pan:1 'elixir --sname node21 -S mix test --only distr21_test' C-m

tmux attach -t pan
