defmodule OtpWithPhx.Application do
  alias OtpWithPhx.Counter
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OtpWithPhx.Repo,
      # Start the Telemetry supervisor
      OtpWithPhxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OtpWithPhx.PubSub},
      # Start the Endpoint (http/https)
      OtpWithPhxWeb.Endpoint,
      ############# Start new addition ! #############
      Counter.child_spec()
      ############# End new addition !   #############
      # Start a worker by calling: OtpWithPhx.Worker.start_link(arg)
      # {OtpWithPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OtpWithPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OtpWithPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
