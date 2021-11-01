# AltDistribution

Замер скорости работы Distribution

Пример сравнения

обмен 1M сообщений локально
 
 elixir --sname node1 -S mix test --only distr3_test
 01:55:44.123 [debug] отработал за 1112 ms
 899'280 сообщений в секунду от процесса и обратно
 mac erl22
 13:37:36.345 [debug] отработал за 759 ms
 1'317'523 сообщений в секунду от процесса и обратно



обмен 1М между двумя нодами на одной машине

 elixir --sname node1 -S mix test --only distr1_test
 elixir --sname node2 -S mix test --only distr2_test
 01:58:00.209 [debug] отработал за 94429 ms
 10589 сообщений в секунду от процесса и обратно
 mac erl22
 13:37:08.334 [debug] отработал за 33217 ms
 30105 сообщений в секунду от процесса и обратно

Разница: между нодами на одной машине в 85 раз медленнее
mac
Разница: между нодами на одной машине в 39.6 раз медленнее

через pipes 1M
  ./start4.sh
  ./start5.sh
 23:53:38.766 [debug] отработал за 45761 ms
 21853 RPS
 mac erl22
 13:42:41.684 [debug] отработал за 16833 ms
 59407 RPS

Через unix sockets
  ./start6.sh
  ./start7.sh
  23:03:33.956 [debug] отработал за 64602 ms
  15479 RPS
  23:37:33.227 [debug] отработал за 56134 ms - с параметрами udp и active true
  17814 RPS
  00:09:48.648 [debug] отработал за 60643 ms - c параметрами udp и active false
  16490 RPS
  mac erl22
  {:active, false} остальное по дефолту
  14:00:30.440 [debug] отработал за 28462 ms
  35134 RPS

## Alternate distribution

 iex --erl "-pa _build/dev/lib/alt_distribution/ebin -proto_dist Elixir.Epmdless -start_epmd false -epmd_module Elixir.Epmdless_epmd_client" --sname foo1

 iex --erl "-pa _build/dev/lib/alt_distribution/ebin -proto_dist Elixir.Epmdless -start_epmd false -epmd_module Elixir.Epmdless_epmd_client" --sname foo2

 Node.ping :"foo1@alexeybolshakov"

 Node.list

## Links

 http://erlang.org/doc/man/erl.html

 http://erlang.org/doc/apps/erts/erl_dist_protocol.html

 http://erlang.org/doc/apps/erts/alt_dist.html

 https://gist.github.com/UA3MQJ/ea57d5004ab654889675058da78ca723

 http://www.ostinelli.net/boost-message-passing-between-erlang-nodes/

 https://github.com/stritzinger/proto_dist

