defmodule RedisQueueParser.RedisManager do
  use GenServer

  def start_link(params) do

  	IO.puts "RedisManager:"
    IO.inspect params

  	GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def read_from_queue do
  	GenServer.call __MODULE__, :read_from_queue
  end

  #####
  # GenServer implementation

  #def handle_cast({:start}, _params) do
  #	redis_worker_pid = :poolboy.checkout(:redis_parser_pool)
  #  GenServer.cast redis_worker_pid, :read_from_redis
  #
  #	{ :noreply, "ok" }
  #end

  def handle_call(:read_from_queue, _from, _params) do

  	redis_worker_pid = :poolboy.checkout(:redis_parser_pool)

  	res = GenServer.call redis_worker_pid, :read_from_queue

  	{ :reply, res, 1 }
  end

end