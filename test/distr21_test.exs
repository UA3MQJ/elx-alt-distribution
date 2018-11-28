defmodule Distr21Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr21_test: true
  @tag timeout: 360_000

  # elixir --sname node3 -S mix test --only distr21_test

  test "client process" do
    {:ok, host} = :inet.gethostname()
    host_str = to_string(host)
    node1 = String.to_atom("node1@" <> host_str)
    :pong = Node.ping(node1)

    time1 = :os.system_time(:millisecond)
    send_msgs("message", node1, 1000_000)
    time2 = :os.system_time(:millisecond)
    Logger.debug "отработал за #{time2 - time1} ms"
  end

  def send_msgs(_msg, _node, 0), do: :ok
  def send_msgs(msg, node, n) do
    pid = self()
    send({:server, node}, {pid, msg})

    receive do
      {^pid, ^msg} -> :ok
    end

    send_msgs(msg, node, n-1)
  end

end
