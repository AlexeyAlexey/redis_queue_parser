defmodule RedisQueueParser.Parser do
  use GenServer

  
  ####
  #External API

  def start_link(params) do
  	{:ok, redis_client_pid} = Exredis.start_link("127.0.0.1", 6379)

  	GenServer.start_link(__MODULE__, redis_client_pid)
  end

  
  #####
  # GenServer implementation

  def init(redis_client_pid) do
  	{:ok, redis_client_pid}
  end

  #def handle_cast({ :read_from_redis }, {redis_client_pid}) do
  #	{ :noreply, {redis_client_pid}}
  #end

  def handle_call(:read_from_queue, _from, redis_client_pid) do
  	
  	resp = handle_response(Exredis.query redis_client_pid, ["RPOP", "action_process"])

  	{ :reply, resp, redis_client_pid }
  end

  def handle_response( :undefined ), do: %{}

  def handle_response( resp ) do 
    :jsx.decode(resp)
    |> Enum.into(%{})
  end

  #def terminate(_reason, {redis_client_pid}) do
  #  Sequence.Stash.save_value stash_pid, current_number
  #end

end