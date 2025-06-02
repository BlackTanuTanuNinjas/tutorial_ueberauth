defmodule TutorialUeberauth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TutorialUeberauthWeb.Telemetry,
      TutorialUeberauth.Repo,
      {DNSCluster, query: Application.get_env(:tutorial_ueberauth, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TutorialUeberauth.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TutorialUeberauth.Finch},
      # Start a worker by calling: TutorialUeberauth.Worker.start_link(arg)
      # {TutorialUeberauth.Worker, arg},
      # Start to serve requests, typically the last entry
      TutorialUeberauthWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TutorialUeberauth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TutorialUeberauthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
