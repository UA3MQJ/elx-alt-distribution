defmodule Distr4Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr4_test: true
  @tag timeout: 360_000

  # elixir --sname node1 -S mix test --only distr4_test

  test "server process" do
    Logger.debug "Start server"

    Logger.debug "Await link channels"
    in_chan = :erlang.open_port('test1.pipe', [:eof, :in])
    Logger.debug "In chan linked"
    out_chan = :erlang.open_port('test2.pipe', [:eof, :out])
    Logger.debug "Out chan linked"

    recv_messages(in_chan, out_chan)
  end

  def recv_messages(in_chan, out_chan) do

    receive do
      {^in_chan, {:data, data}} ->
        # Logger.debug ">>> data=#{inspect data}"
        :erlang.port_command(out_chan, data)
        recv_messages(in_chan, out_chan)
    end

  end
end
