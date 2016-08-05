defmodule RedisQueueParser.Cli do
  
  def main(args \\ []) do
  	IO.inspect args
  	args
  	|> parse_args
  	|> execute_command
  end

  defp parse_args(args) do
  	#{opts, word, _} = args |> OptionParser.parse()
  	#{opts, _, _} = ["--start", "--read_from_redis", "first_function", "--delete", "2"] |> OptionParser.parse(strict: [delete: :integer, read_from_redis: :boolean, start: :boolean])
  	{_, _, opts} = args |> OptionParser.parse(strict: [delete: :integer, read_from_redis: :boolean, start: :boolean, stop: :boolean])
    IO.inspect opts
    opts
  end

  defp execute_command(opts) do

  	IO.inspect opts
  	if opts[:start] do
  	  #RedisQueueParser.start("_type", [])
  	end
  	if opts[:read_from_redis] do

  	  RedisQueueParser.RedisManager.read_from_queue
  	end
  	if opts[:stop] do
  	  RedisQueueParser.stop(:redis_queue_parser)
  	end
  	{:ok, opts}
  end
end