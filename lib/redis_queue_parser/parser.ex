defmodule RedisQueueParser.Parser do
  use GenServer

  
  ####
  #External API
  #def start_link do
    # We now start the GenServer with a `name` option.
  #  IO.puts "lllllll"
  #  GenServer.start_link(__MODULE__, [], name: :queue_parser)
  #end

  def start_link(queue_named) do
  	{:ok, pid} = res = GenServer.start_link(__MODULE__, {queue_named, false})
    IO.puts "start"
    #GenServer.cast(pid, :read_from_queue)
    res 
  end
  
  #####
  # GenServer implementation

  #def init(redis_client_pid) do
  #	{:ok, redis_client_pid}
  #end#


  def handle_cast(:stop, state) do
    { :noreply, state }
  end

  def handle_call(:process_named, _from, {queue_named, read}) do
    {:reply, {queue_named, read}, {queue_named, read} }
  end
  
  def handle_cast(:read_from_queue, {queue_named, continue_reading}) do
    IO.puts "read_from_queue"

    read_from_queue(queue_named, continue_reading)

    { :noreply, {queue_named, false} }
  end

  def handle_call(:read_from_queue, _form, {queue_named, continue_reading}) do
    IO.puts "read_from_queue"
    
    read_from_queue(queue_named, true)

    { :noreply, {queue_named, false} }
  end
  
  defp read_from_queue(queue_named, next) when next == true do

    redis_pid = :poolboy.checkout(:redis_pool)

    res = GenServer.call(redis_pid, { :read_from_queue, queue_named })

    :poolboy.checkin(:redis_pool, redis_pid)

    handle_response( res )
    |> write_to_db

    
    
    next = check_message
    IO.puts next
    read_from_queue(queue_named, next)
  end

  defp read_from_queue(queue_named, next) when next == false do
    child_pid = self()
    parent_pid = :gproc.where({ :n, :l, {:sub_supervisor_parser, queue_named} })
    #GenServer.cast(child_pid, :stop)
    Supervisor.terminate_child(parent_pid, child_pid)
  end

  def handle_response( :undefined ), do: %{}

  def handle_response( res ) do 
    #return json
    :jsx.decode(res)
    |> Enum.into(%{})
  end

  defp write_to_db( %{} ) do
   :timer.sleep(10000)
   %{}
  end
  defp write_to_db(res_json) do
    
  end

  
  defp via_tuple(name) do
    { :via, :gproc, {:n, :l, {:queue_parser, name}} }    
  end

  def check_message do
    #{:"$gen_call", {#PID<0.211.0>, #Reference<0.0.1.1076>}, :check_state}
    #{:"$gen_cast", :stop}
    receive do
      {_, :stop} ->  
        #IO.puts "Got hello from"
        false
    after 
      0 -> true
    end
  end


end