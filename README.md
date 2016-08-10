# RedisQueueParser

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `redis_queue_parser` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:redis_queue_parser, "~> 0.1.0"}]
    end
    ```

  2. Ensure `redis_queue_parser` is started before your application:

    ```elixir
    def application do
      [applications: [:redis_queue_parser]]
    end
    ```

    
#in host
 epmd -kill

 epmd -daemon

#in host mashin (https://help.ubuntu.com/community/SSH/OpenSSH/PortForwarding)(https://mfeckie.github.io/Remote-Profiling-Elixir-Over-SSH/)

#ssh -N -L 43518:localhost:43518 -L 4369:localhost:4369 vagrant@192.168.55.57

#in host
# erl -name node2@192.168.55.57 -setcookie 123 -run observer

in observ
Nodes -> Connect to node -> node1@127.0.0.1

in guest
iex --name node1@127.0.0.1 --cookie 123  --erl "-config sys.config" -S mix

iex --name node1@127.0.0.1 --cookie 123 



You can use the --detached option to start the runtime system detached from the system console. It is meant to be used for running daemons and backgrounds processes:
elixir --detached -S mix run (http://stackoverflow.com/questions/24039245/how-do-elixir-with-mix-make-a-daemon)

(https://github.com/bitwalker/exrm)
(https://github.com/phoenixframework/phoenix/issues/1041)




vagrant@vagrant-ubuntu-trusty-64:/vagrant$ iex --name node5@127.0.0.1 --cookie 123
iex(node5@127.0.0.1)31> Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.RedisManager.read_from_queue end)
Hello
#PID<9000.848.0>




Supervisor.which_children(:sub_supervisor)

[{:undefined, #PID<0.299.0>, :worker, [RedisQueueParser.Parser]},
 {:undefined, #PID<0.214.0>, :worker, [RedisQueueParser.Parser]}]

RedisQueueParser.SubSupervisor.start_parser("2")

> :gproc.where({:n, :l, {:queue_parser, :"1"}})    
#PID<0.214.0>


GenServer.call(pid, :process_named)


 RedisQueueParser.SubSupervisor.start_parser("queue_1") 
{:ok, #PID<0.224.0>}
iex(redis_queue_parser@127.0.0.1)2> {:ok, pid} = RedisQueueParser.SubSupervisor.start_parser("queue_2")
{:ok, #PID<0.226.0>}
iex(redis_queue_parser@127.0.0.1)3> pid
#PID<0.226.0>

> Supervisor.start_child(pid, ["1"])
{:ok, #PID<0.231.0>}
iex(redis_queue_parser@127.0.0.1)6> Supervisor.start_child(pid, ["2"])
{:ok, #PID<0.233.0>}



> {:ok, pid_1} = RedisQueueParser.SubSupervisor.init_parser("queue_1")
{:ok, #PID<0.218.0>}
iex(redis_queue_parser@127.0.0.1)2> RedisQueueParser.SubSupervisorParser.start_new_parser("queue_1")
start_new_parser

> Supervisor.which_children(pid)                                  
[{:undefined, #PID<0.289.0>, :worker, [RedisQueueParser.Parser]},
 {:undefined, #PID<0.274.0>, :worker, [RedisQueueParser.Parser]}]


#delete supervisor 
> pid_parent = :gproc.where({:n, :l, {:sub_supervisor_parser, "queue_1"}}) 
Supervisor.terminate_child(:sub_supervisor, pid_parent)

'redis_queue_parser_manager'
0.1) ~$ iex --name node1@127.0.0.1 --cookie 123
0.1) iex --name node1@127.0.0.1 --cookie 123 -S mix
0.2) Node.connect(:"redis_queue_parser@127.0.0.1") 
0.3) Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.ParsersManager.stop_parser_of("queue_1") end)

0) /redis_queue_parser$ iex -S mix


Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.ParsersManager.init_parser("queue_1", function) end)
Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.ParsersManager.start_new_parser("queue_1") end)  

1) function =  fn l -> IO.inspect l end
   RedisQueueParser.ParsersManager.init_parser("queue_1", ) 
   

2) RedisQueueParser.ParsersManager.start_new_parser("queue_1")

3) RedisQueueParser.ParsersManager.stop_parser_of("queue_1")

4) RedisQueueParser.ParsersManager.destroy_all_parsers_without_check_child("queue_1")

5) RedisQueueParser.ParsersManager.list_of_init_parsers => ["queue_3", "queue_2", "queue_1"]
  > RedisQueueParser.ParsersManager.list_of_init_parsers |> Enum.map(fn(el) -> { :n, :l, {:sub_supervisor_parser, el} } end) |> Enum.map(fn(el) -> :gproc.where(el) end)  [#PID<0.232.0>, #PID<0.230.0>, #PID<0.228.0>]





redis 
  127.0.0.1:6379> RPUSH "queue_1" "{\"name\":\"process_action.action_controller\",\"payload\":{\"controller\":\"WelcomeController\",\"action\":\"index\",\"params\":{\"controller\":\"welcome\",\"action\":\"index\"},\"format\":\"html\",\"method\":\"GET\",\"path\":\"/\",\"status\":200,\"view_runtime\":1525.7584779999995,\"db_runtime\":642.8488560000003,\"user_id\":2,\"log_unique_id\":\"2163658047998db73fdf00059b931453100275\",\"remote_ip\":\"127.0.0.1\",\"request_user_agent\":\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36\",\"request_from_page\":\"\",\"session_id\":\"96cbc8ea2291fb7570cec367e137535e\",\"body_response\":\"\",\"request_headers\":\"\"},\"time\":\"2016-01-18T08:57:55+02:00\",\"transaction_id\":\"981019b65417085881c9\",\"end\":\"2016-01-18T08:57:58+02:00\",\"duration\":2669.970255}"



"{\"name\":\"process_action.action_controller\",\"payload\":{\"controller\":\"WelcomeController\",\"action\":\"index\",\"params\":{\"controller\":\"welcome\",\"action\":\"index\"},\"format\":\"html\",\"method\":\"GET\",\"path\":\"/\",\"status\":200,\"view_runtime\":1525.7584779999995,\"db_runtime\":642.8488560000003,\"user_id\":2,\"log_unique_id\":\"2163658047998db73fdf00059b931453100275\",\"remote_ip\":\"127.0.0.1\",\"request_user_agent\":\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36\",\"request_from_page\":\"\",\"session_id\":\"96cbc8ea2291fb7570cec367e137535e\",\"body_response\":\"\",\"request_headers\":\"\"},\"time\":\"2016-01-18T08:57:55+02:00\",\"transaction_id\":\"981019b65417085881c9\",\"end\":\"2016-01-18T08:57:58+02:00\",\"duration\":2669.970255}"











> Timex.parse("2016-01-18T08:57:55+02:00", "{ISO:Extended}")
{:ok, #<DateTime(2016-01-18T08:57:55+02:00 Etc/GMT-2)>}
iex(redis_queue_parser@127.0.0.1)2> Timex.parse("", "{ISO:Extended}")                         
{:error, "Input datetime string cannot be empty!"}



:gproc.first({:l, :n})    
{{:n, :l, {:sub_supervisor_parser}}, :n}


> :gproc.lookup_values({:n, :l, {:sub_supervisor_parser}})
[{#PID<0.208.0>, :undefined}]

:gproc.last({:l, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n}


> :gproc.last({:l, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n}
iex(redis_queue_parser@127.0.0.1)8> :gproc.last({:l, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)9> :gproc.first({:l, :n})    
{{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n}


next(Context, K) 
> :gproc.next({:l, :n}, {:l, :n, {}})      
{:n, :l, {:sub_supervisor_parser, "queue_1"}}



 :gproc.next({:l, :n}, :gproc.first({:l, :n}) )

{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)44> :gproc.next({:l, :n}, :gproc.first({:l, :n}) )
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)45> :gproc.next({:l, :n}, :gproc.first({:l, :n}) )
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}



> :gproc.next({:l, :n}, :gproc.first({:l, :n}) )                               
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)51> :gproc.next({:l, :n}, :gproc.first({:l, :n}) )
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)52> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n} )
{{:n, :l, {:sub_supervisor_parser, "queue_3"}}, :n}
iex(redis_queue_parser@127.0.0.1)53> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_3"}}, :n} )
{{:n, :l, {:sub_supervisor_parser, "queue_4"}}, :n}
iex(redis_queue_parser@127.0.0.1)54> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_3"}}, :n} )
{{:n, :l, {:sub_supervisor_parser, "queue_4"}}, :n}
iex(redis_queue_parser@127.0.0.1)55> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_4"}}, :n} )
:"$end_of_table"


:gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, '_'}}, :n}) 
{{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n}

> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, '_'}}, :n})    
{{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n}
iex(redis_queue_parser@127.0.0.1)67> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_1"}}, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n}
iex(redis_queue_parser@127.0.0.1)68> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_2"}}, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_3"}}, :n}
iex(redis_queue_parser@127.0.0.1)69> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_3"}}, :n})
{{:n, :l, {:sub_supervisor_parser, "queue_4"}}, :n}
iex(redis_queue_parser@127.0.0.1)70> :gproc.next({:l, :n}, {{:n, :l, {:sub_supervisor_parser, "queue_5"}}, :n})
:"$end_of_table"



> RedisQueueParser.Repo.insert_all("users", [ [status: 1]])

13:25:38.773 [debug] QUERY OK db=18.1ms
INSERT INTO `users` (`status`) VALUES (?) [1]
{1, nil}
iex(redis_queue_parser@127.0.0.1)5> 





json

{:ok, date_time} = Timex.parse(json["time"], "{ISO:Extended}")
date_time_str = DateTime.to_string Timezone.convert(date_time, "UTC")

json_payload = json["payload"] |> Map.drop(["body_response", "request_headers"])

json_db = Map.put(json, "payload", json_payload)

[ json["name"], [ [log_unique_id: json["payload"]["log_unique_id"],
                   user_id: json["payload"]["user_id"],
                   session_id: json["payload"]["session_id"],
                   request_user_agent: json["payload"]["request_user_agent"],
                   request_headers: json["payload"]["request_headers"],
                   request_from_page: json["payload"]["request_from_page"],
                   controller: json["payload"]["controller"],
                   action: json["payload"]["action"],
                   status: json["payload"]["status"],
                   start_time:  date_time_str, 
                   remote_ip: json["payload"]["remote_ip"], 
                   duration: json["duration"], 
                   view_runtime: json["payload"]["view_runtime"],
                   db_runtime: json["payload"]["db_runtime"],
                   process: json_db,
                   body_response: json["payload"]["body_response"]
                  ]



 ] 


]