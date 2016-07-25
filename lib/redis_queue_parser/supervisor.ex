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
  	#Start thecowboy?????
  	# { :ok, stash } = Supervisor.start_child(sup, worker(Sequence.Stash, []))
    
  	#start the subsupervisor for the redis sequence
  	result_sub = Supervisor.start_child( sup, supervisor(RedisQueueParser.SubSupervisor, [1]) )
    IO.puts "start_workers"
    IO.inspect result_sub
  	result_sub
  end
  
  def init(_) do
  	supervise [], strategy: :one_for_one
  end

end