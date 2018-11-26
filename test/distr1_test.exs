defmodule Distr1Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr1_test: true
  @tag timeout: 360_000

  # elixir --sname node1 -S mix test --only distr1_test

  test "server process" do
    Logger.debug "Start server"
    Process.register(self(), :server)

    recv_messages()
  end

  def recv_messages() do
    receive do
      {pid, message} ->
        #Logger.debug ">> rcv message=#{inspect message}"
        send(pid, {pid, message})
        recv_messages()
    end
  end
end
