defmodule AnalisiElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :analisi_elixir,
      version: "0.1.0",
      elixir: "~> 1.16.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:observer_cli, "~> 1.6"},
      {:csv, "~> 3.2.1"},
      # {:tortoise311, "~> 0.11.5"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
