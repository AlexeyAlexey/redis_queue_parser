defmodule RedisQueueParser.Manager  do
  use GenServer

  #import Supervisor.Spec

  def start_link(params) do    
    #Agent.start_link(fn -> [] end, name: :sub_supervisor_parser)

  	GenServer.start_link(__MODULE__, {params}, name: __MODULE__)
  end

  
  def init_parser(name, function) do
    result = Supervisor.start_child(:sub_supervisor_parsers, [name, function])

    #save_name_in_sub_supervisor_parser(result, name)

    result
  end

  def start_new_parser(name_of_queue) do
    sup_pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    if sup_pid == :undefined do
      {:error, "Can not find queue named #{name_of_queue}"}
    else
      #{:ok, child_pid} = res = Supervisor.start_child(sup_pid, [name_of_queue])
      {:ok, child_pid} = res = Supervisor.start_child(sup_pid, [])
      #GenServer.call(child_pid, :read_from_queue)
      #GenServer.cast(child_pid, :read_from_queue)
      res
    end
  end

  def destroy_all_parsers_without_check_child(name_of_queue) do
    sup_pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, name_of_queue} })
    if sup_pid == :undefined do
      IO.puts "Can not find queue named #{name_of_queue}"
    else
      Supervisor.terminate_child(:sub_supervisor_parsers, sup_pid)
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

  defp list_of_init_parsers({{:n, :l, {:sub_supervisor_parser, '_'}}, :n}, _res) do
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
  defp list_of_init_parsers(_, res) do
    res
  end
  #####
  # GenServer implementation



  def test_parser do
    use Timex
    fn (json) ->
      #json_str = "{\"name\":\"process_action.action_controller\",\"payload\":{\"controller\":\"WelcomeController\",\"action\":\"index\",\"params\":{\"controller\":\"welcome\",\"action\":\"index\"},\"format\":\"html\",\"method\":\"GET\",\"path\":\"/\",\"status\":200,\"view_runtime\":1525.7584779999995,\"db_runtime\":642.8488560000003,\"user_id\":2,\"log_unique_id\":\"2163658047998db73fdf00059b931453100275\",\"remote_ip\":\"127.0.0.1\",\"request_user_agent\":\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36\",\"request_from_page\":\"\",\"session_id\":\"96cbc8ea2291fb7570cec367e137535e\",\"body_response\":\"\",\"request_headers\":\"\"},\"time\":\"2016-01-18T08:57:55+02:00\",\"transaction_id\":\"981019b65417085881c9\",\"end\":\"2016-01-18T08:57:58+02:00\",\"duration\":2669.970255}"
      
      #json = :jsx.decode(json_str, [:return_maps])
      if Map.has_key?(json, "name") == true do
        {:ok, date_time} = Timex.parse(json["time"], "{ISO:Extended}")
        date_time_str = DateTime.to_string Timezone.convert(date_time, "UTC")

        json_payload = json["payload"] |> Map.drop(["body_response", "request_headers"])

        json_db = Map.put(json, "payload", json_payload)

        [ "action_controller_loggers",  [log_unique_id: json["payload"]["log_unique_id"],
                                           user_id:      json["payload"]["user_id"],
                                           session_id:   json["payload"]["session_id"],
                                           request_user_agent: json["payload"]["request_user_agent"],
                                           request_headers:    json["payload"]["request_headers"],
                                           request_from_page:  json["payload"]["request_from_page"],
                                           controller:         json["payload"]["controller"],
                                           action:             json["payload"]["action"],
                                           status:             json["payload"]["status"],
                                           start_time:    date_time_str, 
                                           remote_ip:     json["payload"]["remote_ip"], 
                                           duration:      json["duration"], 
                                           view_runtime:  json["payload"]["view_runtime"],
                                           db_runtime:    json["payload"]["db_runtime"],
                                           process:       :jsx.encode(json_db),
                                           body_response: json["payload"]["body_response"]
                                          ]
                                         


        ]
      else
        %{}
      end
    end
  end

  
  

end