defmodule ElvenGard.Network.MixProject do
  use Mix.Project

  @app_name "ElvenGard.Network"
  @version "0.1.0-alpha"
  @github_link "https://github.com/ImNotAVirus/elvengard_network"

  def project do
    [
      app: :elvengard_network,
      version: @version,
      elixir: "~> 1.13",
      name: @app_name,
      description: "MMORPG Game Server toolkit written in Elixir",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      docs: docs(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ranch, "~> 2.1"},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:excoveralls, "~> 0.15", only: :test, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["ImNotAVirus"],
      licenses: ["MIT"],
      links: %{github: @github_link},
      files: ~w(lib CHANGELOG.md LICENSE.md mix.exs README.md)
    ]
  end

  defp docs do
    [
      main: @app_name,
      source_ref: "v#{@version}",
      source_url: @github_link,
      # logo: "path/to/logo.png",
      extra_section: "GUIDES",
      extras: extras(),
      groups_for_extras: groups_for_extras()
      # groups_for_modules: [
      #   "Textual protocol specs": ~r/ElvenGard\.Protocol\.Textual\.?/,
      #   "Binary protocol specs": ~r/ElvenGard\.Protocol\.Binary\.?/,
      #   PacketHandler: ~r/ElvenGard\.PacketHandler\./
      # ]
    ]
  end

  defp extras do
    ["README.md": [title: "Overview"]] ++ Path.wildcard("guides/**/*.md")
  end

  defp groups_for_extras do
    [
      Introduction: ~r/(README.md|guides\/introduction\/.?)/,
      Topics: ~r/guides\/topics\/.?/
    ]
  end
end
