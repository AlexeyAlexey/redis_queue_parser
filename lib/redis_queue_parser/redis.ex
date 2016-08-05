defmodule RedisQueueParser.Redis do
  use GenServer

  
  ####
  #External API

  def start_link(params) do
  	{:ok, redis_client_pid} = Exredis.start_link("127.0.0.1", 6379)

  	GenServer.start_link(__MODULE__, {redis_client_pid})
  end

 
  
  #####
  # GenServer implementation

  def init(redis_client_pid) do
  	{:ok, redis_client_pid}
  end

  def handle_call({:read_from_queue, queue_named}, _from, {redis_client_pid}) do
  	
    resp = Exredis.query redis_client_pid, ["RPOP", queue_named]

  	{ :reply, resp, {redis_client_pid} }
  end

  def terminate(_reason, {redis_client_pid}) do
    
    redis_client_pid |> Exredis.stop

    :ok
  end

end