defmodule RedisQueueParser.Supervisor do
  use Supervisor

  def start_link(_params) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [])
    IO.puts "Supervisor:"
    IO.inspect sup
    start_workers(sup, [])#
    result
  end
  def start_workers(sup, _params) do
  	#start the subsupervisor for the redis sequence
  	result_sub = Supervisor.start_child( sup, supervisor(RedisQueueParser.SubSupervisor, [1]) )
  	result_sub
  end
  
  def init(_) do
    pool_options = [
      name: {:local, :redis_pool},
      worker_module: RedisQueueParser.Redis,
      size: 5,
      max_overflow: 0
    ]

    child_processes = [ :poolboy.child_spec(:redis_pool, pool_options, []), worker(RedisQueueParser.ParsersManager, [1]),
                        supervisor(RedisQueueParser.Repo, []) ]
  	supervise child_processes, strategy: :one_for_one
  end

end