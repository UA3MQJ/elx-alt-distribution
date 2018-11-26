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
