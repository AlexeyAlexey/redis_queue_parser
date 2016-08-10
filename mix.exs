defmodule RedisQueueParser.Mixfile do
  use Mix.Project

  def project do
    [app: :redis_queue_parser,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: escript,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def escript do
    [main_module: RedisQueueParser.Cli]
  end
  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :exredis, :mariaex, :ecto, :poolboy, :gproc, :timex],
     mod: {RedisQueueParser, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{ :exredis, ">= 0.2.4" },
     { :jsx,     "~> 2.0"   },
     { :mariaex, "~> 0.7.3" },
     { :ecto,    "~> 2.0.0" },
     { :poolboy, "~> 1.5"   },
     { :gproc,   "~> 0.5.0" },
     {:timex,    "~> 3.0"   }]
  end
end
