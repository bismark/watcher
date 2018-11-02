defmodule Watcher.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Watcher.Socket
    ]

    opts = [strategy: :one_for_one, name: Watcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
