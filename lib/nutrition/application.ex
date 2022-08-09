defmodule Nutrition.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Nutrition.Repo,
      # Start the Telemetry supervisor
      NutritionWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nutrition.PubSub},
      # Start the Endpoint (http/https)
      NutritionWeb.Endpoint
      # Start a worker by calling: Nutrition.Worker.start_link(arg)
      # {Nutrition.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nutrition.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NutritionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
