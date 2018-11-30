# AltDistribution

Замер скорости работы Distribution

Пример сравнения

обмен 1M сообщений локально
 
 elixir --sname node1 -S mix test --only distr3_test
 01:55:44.123 [debug] отработал за 1112 ms
 899'280 сообщений в секунду от процесса и обратно

обмен 1М между двумя нодами на одной машине

 elixir --sname node1 -S mix test --only distr1_test
 elixir --sname node2 -S mix test --only distr2_test
 01:58:00.209 [debug] отработал за 94429 ms
 10589 сообщений в секунду от процесса и обратно

Разница: между нодами на одной машине в 85 раз медленнее

через pipes 1M
  ./start4.sh
  ./start5.sh
 23:53:38.766 [debug] отработал за 45761 ms
 21853 RPS

Через unix sockets
  ./start6.sh
  ./start7.sh
  23:03:33.956 [debug] отработал за 64602 ms
  15479 RPS

## Links

 http://erlang.org/doc/man/erl.html

 http://erlang.org/doc/apps/erts/erl_dist_protocol.html

 http://erlang.org/doc/apps/erts/alt_dist.html

 https://gist.github.com/UA3MQJ/ea57d5004ab654889675058da78ca723

 http://www.ostinelli.net/boost-message-passing-between-erlang-nodes/