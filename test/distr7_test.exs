defmodule Distr7Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr7_test: true
  @tag timeout: 360_000

  # elixir --sname node2 -S mix test --only distr7_test

  test "client process" do
    Logger.debug "Start client"

    :file.delete("test2.sock")
    {ok, sock2} = :gen_udp.open(0, [{:ifaddr, {:local, 'test2.sock'}}, {:active, false}, {:recbuf, 16}, {:sndbuf, 16}, {:read_packets, 2}])

    time1 = :os.system_time(:millisecond)
    send_msgs('message\n', sock2, 1000_000)
    time2 = :os.system_time(:millisecond)
    Logger.debug "отработал за #{time2 - time1} ms"
  end

  def send_msgs(_msg, _, 0), do: :ok
  def send_msgs(msg, sock2, n) do
    :gen_udp.send(sock2, {:local, 'test1.sock'}, 0, msg)

    # receive do
    #   {:udp, ^sock2, {:local, _}, 0, data} ->
    #     # Logger.debug ">>> data=#{inspect data}"
    #     :ok
    # end

    {:ok, data} = :gen_udp.recv(sock2, 0)
    # Logger.debug ">>> data=#{inspect data}"

    send_msgs(msg, sock2, n-1)
  end

end
