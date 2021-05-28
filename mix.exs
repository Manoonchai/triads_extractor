defmodule TriadsExtractor.MixProject do
  use Mix.Project

  def project do
    [
      app: :triads_extractor,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  def escript do
    [main_module: TriadsExtractor.CLI]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, "~> 2.4"}
    ]
  end
end
