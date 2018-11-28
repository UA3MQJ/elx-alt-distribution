mkfifo test1.pipe
mkfifo test2.pipe
elixir --sname node1 -S mix test --only distr4_test
