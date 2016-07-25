defmodule RedisQueueParser.SubSupervisor do
  use Supervisor

  def start_link(_) do
  	#{:ok, _pid} = Supervisor.start_link(__MODULE__, [])
  	result = Supervisor.start_link(__MODULE__, [])
    IO.puts "SubSupervisor:"
    IO.inspect result
  	result
  end
  def init(_) do
  	#add redis processes
  	#use poolboy
  	# Here are my pool options
    pool_options = [
      name: {:local, :redis_parser_pool},
      worker_module: RedisQueueParser.Parser,
      size: 5,
      max_overflow: 5
    ]

  	child_processes = [ :poolboy.child_spec(:redis_parser_pool, pool_options, []), worker(RedisQueueParser.RedisManager, [1]) ]
  	#child_processes = [ worker(RedisQueueParser.RedisManager, [1]) ]
  	supervise child_processes, strategy: :one_for_one
  end
end