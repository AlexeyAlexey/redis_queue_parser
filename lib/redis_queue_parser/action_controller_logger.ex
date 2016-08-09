defmodule RedisQueueParser.ActionControllerLogger do
  use Ecto.Schema

  # action_controller_loggers is the DB table
  schema "action_controller_loggers" do
    field :log_unique_id,      :string#varchar(255)
	field :user_id,        	   :integer#int(11)
	field :session_id,         :string#varchar(255)
	field :request_user_agent, :string#varchar(255)
	field :request_headers,    :string#text
	field :request_from_page,  :string#text
	field :controller,         :string#varchar(255)
	field :action,        	   :string#varchar(255)
	field :status,        	   :integer#smallint(6)
	field :remote_ip,          :string#varchar(255)
	field :process,        	   :string#longtext
	field :body_response,      :string#longtext
	field :start_time,         Ecto.DateTime
	field :view_runtime,       :float
	field :db_runtime,         :float
	field :duration,           :float
  end
end


