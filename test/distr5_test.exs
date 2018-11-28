defmodule Distr5Test do
  use ExUnit.Case
  doctest AltDistribution
  require Logger

  @tag distr5_test: true
  @tag timeout: 360_000

  # elixir --sname node2 -S mix test --only distr5_test

  test "client process" do
    Logger.debug "Start client"
    
    Logger.debug "Await link channels"
    out_chan = :erlang.open_port('test1.pipe', [:eof, :out])
    Logger.debug "Out chan linked"
    in_chan = :erlang.open_port('test2.pipe', [:eof, :in])
    Logger.debug "In chan linked"


    time1 = :os.system_time(:millisecond)
    send_msgs('message\n', in_chan, out_chan, 1000_000)
    time2 = :os.system_time(:millisecond)
    Logger.debug "отработал за #{time2 - time1} ms"
  end

  def send_msgs(_msg, _, _, 0), do: :ok
  def send_msgs(msg, in_chan, out_chan, n) do
    #pid = self()
    #send({:server, node}, {pid, msg})

    #receive do
    #  {^pid, ^msg} -> :ok
    #end

    :erlang.port_command(out_chan, msg)

    receive do
      {^in_chan, {:data, ^msg}} ->
        # Logger.debug ">>> rcv #{inspect msg}"
	:ok
    end

    send_msgs(msg, in_chan, out_chan, n-1)
  end

end
