defmodule RedisQueueParser.SubSupervisor do
  use Supervisor

  def start_link(_) do
  	#{:ok, _pid} = Supervisor.start_link(__MODULE__, [])
  	result = Supervisor.start_link(__MODULE__, [], name: :sub_supervisor)
   
    #Agent.start_link(fn -> List.new end, name: :sub_supervisor)
    #Agent.start_link(fn -> [] end, name: :sub_supervisor_parser)
  	
    result
  end

  def init_parser(name) do
    result = Supervisor.start_child(:sub_supervisor, [name])

    save_name_in_sub_supervisor_parser(result, name)

    result
  end

  def init(params) do
    child_processes = [ worker(RedisQueueParser.SubSupervisorParser, []) ]

  	supervise child_processes, strategy: :simple_one_for_one
  end

 
  defp save_name_in_sub_supervisor_parser({:ok, pid}, name) do
    Agent.update(:sub_supervisor_parser, fn list_of_names -> [ name | list_of_names] end)
  end

  defp save_name_in_sub_supervisor_parser(_, _) do
    
  end
end