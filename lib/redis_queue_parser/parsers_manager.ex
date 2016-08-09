defmodule RedisQueueParser.ParsersManager do
  use GenServer

  import Supervisor.Spec

  def start_link(params) do    
    Agent.start_link(fn -> [] end, name: :sub_supervisor_parser)

  	GenServer.start_link(__MODULE__, {params}, name: __MODULE__)
  end

  
  def init_parser(name) do
    result = Supervisor.start_child(:sub_supervisor, [name])

    #save_name_in_sub_supervisor_parser(result, name)

    result
  end

  def destroy_all_parsers_without_check_child(name_of_queue) do
    sup_pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    if sup_pid == :undefined do
      IO.puts "Can not find queue named #{name_of_queue}"
    else
      Supervisor.terminate_child(:sub_supervisor, sup_pid)
    end
  end

  def get_info_about_child(name_of_queue) do
    pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    Supervisor.which_children(pid) 
  end
  
  #defp info_about_child({_, pid, _, _}) do
  #  IO.inspect Process.info(pid)
  #end 
  #defp info_about_child(nil) do
  #  IO.puts "Empty"
  #end 

  def start_new_parser(name_of_queue) do
    sup_pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    if sup_pid == :undefined do
      IO.puts "Can not find queue named #{name_of_queue}"
    else
      {:ok, child_pid} = res = Supervisor.start_child(sup_pid, [name_of_queue])
      GenServer.call(child_pid, :read_from_queue)
    end
  end

  def list_of_parsers_of(name_of_queue) do
    pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    Supervisor.which_children(pid)                                  
    #[{:undefined, #PID<0.289.0>, :worker, [RedisQueueParser.Parser]},
    # {:undefined, #PID<0.274.0>, :worker, [RedisQueueParser.Parser]}]
  end

  #stop one parser
  def stop_parser_of(name_of_queue) do
    pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    Supervisor.which_children(pid)
    |> List.first
    |> stop_first_child
  end

  defp stop_first_child(nil) do
    {:ok, "can not find child"}
  end
  defp stop_first_child({_, pid, _, _}) do
    IO.inspect pid
    GenServer.cast(pid, :stop)
    #Process.send(pid, {:kjhkjjh})
  end

  def list_of_init_parsers() do
    list_of_init_parsers({{:n, :l, {:sub_supervisor_parser, '_'}}, :n}, []) 
  end

  #defp save_name_in_sub_supervisor_parser({:ok, pid}, name) do
  #  Agent.update(:sub_supervisor_parser, fn list_of_names -> [ name | list_of_names] end)
  #end

  #defp save_name_in_sub_supervisor_parser(_, _) do
  #  
  #end

  defp list_of_init_parsers({{:n, :l, {:sub_supervisor_parser, '_'}}, :n}, res) do
    found = :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, '_'}}, :n})
    list_of_init_parsers(found, [])
  end
  defp list_of_init_parsers({{:n, :l, {:sub_supervisor_parser, name}}, :n}, res ) do
    found = :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, name}}, :n})
    list_of_init_parsers(found, [name | res])
  end
  defp list_of_init_parsers(:"$end_of_table", res) do
    res
  end
  defp list_of_init_parsers(_, res \\ []) do
    res
  end
  #####
  # GenServer implementation

  
  

end