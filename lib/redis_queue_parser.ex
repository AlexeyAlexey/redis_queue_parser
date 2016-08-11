defmodule RedisQueueParser do
  use Application

  #@name :redis_queue_parser_global
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
  	#Node.start(:"redis_queue_parser@127.0.0.1")
  	#Node.set_cookie(Node.self(), :"123")
    {:ok, _pid} = RedisQueueParser.Supervisor.start_link([])
  end

end
