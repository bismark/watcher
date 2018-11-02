defmodule Watcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :watcher,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Watcher.Application, []}
    ]
  end

  defp deps do
    [
      {:websockex, "~> 0.4.1"},
      {:abi, "~> 0.1.12"},
      {:jason, "~> 1.0"}
    ]
  end
end
