# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :kernel,
  inet_dist_listen_min: 43518,
  inet_dist_listen_max: 43518 

config :redis_queue_parser, RedisQueueParser.Repo,
  adapter:  Ecto.Adapters.MySQL,
  database: "redmine_clear_development",
  username: "root",
  password: "1828smile",
  hostname: "localhost"

config :redis_queue_parser, RedisQueueParser.Redis,
  url: "redis://127.0.0.1:6379",
  reconnect: :no_reconnect,
  max_queue: :infinity
  #url: "redis://user:password@host:1234/10",
  #reconnect: :no_reconnect,
  #max_queue: :infinity

config :redis_queue_parser, RedisQueueParser.Supervisor,
  redis_pool: %{size: 5, max_overflow: 0}
  
# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :redis_queue_parser, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:redis_queue_parser, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
