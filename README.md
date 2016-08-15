#RedisQueueParser

##See develop branch

##In development state

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

On host
epmd -kill

epmd -daemon

On host mashin (https://help.ubuntu.com/community/SSH/OpenSSH/PortForwarding)(https://mfeckie.github.io/Remote-Profiling-Elixir-Over-SSH/)

ssh -N -L 43518:localhost:43518 -L 4369:localhost:4369 vagrant@192.168.55.57

On host
erl -name node2@192.168.55.57 -setcookie 123 -run observer



You can use the --detached option to start the runtime system detached from the system console. It is meant to be used for running daemons and backgrounds processes:

elixir --detached -S mix run (http://stackoverflow.com/questions/24039245/how-do-elixir-with-mix-make-a-daemon)

(https://github.com/bitwalker/exrm)
(https://github.com/phoenixframework/phoenix/issues/1041)



0.1) ~$ iex --name node1@127.0.0.1 --cookie 123
0.1) iex --name node1@127.0.0.1 --cookie 123 -S mix
0.2) Node.connect(:"redis_queue_parser@127.0.0.1") 
0.3) Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.Manager.stop_parser_of("queue_1") end)

0) /redis_queue_parser$ iex -S mix

Node.connect(:"redis_queue_parser@127.0.0.1")
Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.Manager.init_parser("queue_1", function) end)
Node.spawn(:"redis_queue_parser@127.0.0.1", fn -> RedisQueueParser.Manager.start_new_parser("queue_1") end)  

http://elixir-lang.org/docs/stable/iex/IEx.html
iex --name node1@127.0.0.1 --cookie 123 --remsh redis_queue_parser@127.0.0.1
0) iex --name redis_queue_parser@127.0.0.1 --cookie 123 -S mix

1) function =  fn l -> IO.inspect l end
   RedisQueueParser.Manager.init_parser("queue_1", function) 
   

2) RedisQueueParser.Manager.start_new_parser("queue_1")

3) RedisQueueParser.Manager.stop_parser_of("queue_1")

4) RedisQueueParser.Manager.destroy_all_parsers_without_check_child("queue_1")

5) RedisQueueParser.Manager.list_of_init_parsers => ["queue_3", "queue_2", "queue_1"]




iex --name redis_queue_parser@127.0.0.1 --cookie 123  -S mix run --no-halt

elixir --detached --name redis_queue_parser@127.0.0.1 --cookie 123 -S mix run --no-halt


