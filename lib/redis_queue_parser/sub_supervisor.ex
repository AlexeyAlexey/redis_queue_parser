defmodule RedisQueueParser.SubSupervisor do
  use Supervisor

  def start_link(_) do
    #result = Supervisor.start_link(__MODULE__, [], name: :sub_supervisor)
  	result = Supervisor.start_link(__MODULE__, [], name: :sub_supervisor_parsers)
     
    result
  end

  def init(params) do
    child_processes = [ worker(RedisQueueParser.SubSupervisorParser, []) ]

  	supervise child_processes, strategy: :simple_one_for_one
  end
 
end