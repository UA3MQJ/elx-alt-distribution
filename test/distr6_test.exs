defmodule Distr6Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr6_test: true
  @tag timeout: 360_000

  # elixir --sname node1 -S mix test --only distr6_test

  test "server process" do
    Logger.debug "Start server"

    :file.delete("test1.sock")
    {ok, sock1} = :gen_udp.open(0, [{:ifaddr, {:local, 'test1.sock'}}])

    recv_messages(sock1)
  end

  def recv_messages(sock1) do

    receive do
      {:udp, ^sock1, {:local, _}, 0, data} ->
        # Logger.debug ">>> data=#{inspect data}"
        :gen_udp.send(sock1, {:local, 'test2.sock'}, 0, data)

        recv_messages(sock1)
    end

  end
end
