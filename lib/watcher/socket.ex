defmodule Watcher.Socket do
  use WebSockex

  @url ""

  defstruct [
    req_id: 0

  de start_link(_) do
    WebSockex.start_link(@url, __MODULE__, %{}, name: __MODULE__)
  end

  def subscribe(address) do
    WebSockex.cast(__MODULE__, {:subscribe, address})
  end

  def handle_connect(_conn, state) do
    IO.puts "we did it!"
    {:ok, state}
  end

  def handle_cast({:subscribe, address}, state) do
    msg = %{
      "id": 1,
      "method": "eth_subscribe",
      "jsonrpc": "2.0",
      "params": [
        "logs",
        %{
          "topics": [
            "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
            nil,
            format_address(address)
          ]
        }
      ]
    }
    |> Jason.encode!()
    {:reply, {:text, msg}, state}
  end

  def handle_frame({:text, text}, state) do
    msg = Jason.decode!(text)

    {:ok, state}
  end

  def format_address(address) do
    integer =
      address
      |> String.slice(2..-1)
      |> String.to_integer(16)

    padded =
      '~64.16.0B'
      |> :io_lib.format([integer])
      |> to_string

    "0x" <> padded
  end

end

