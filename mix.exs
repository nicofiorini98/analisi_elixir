defmodule AnalisiElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :analisi_elixir,
      version: "0.1.0",
      elixir: "~> 1.16.0",
      start_permanent: Mix.env() == :test,
      deps: deps(),
      env: [dev: [env: Mix.env()]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TaskApplication.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:observer_cli, "~> 1.6"},
      # {:csv, "~> 3.2.1"},                   # csv  library
      {:poison, "~> 5.0"}                   # json library
      # {:tortoise311, "~> 0.11.5"}
    ]
  end
end
