defmodule Nutrition.Repo do
  use Ecto.Repo,
    otp_app: :nutrition,
    adapter: Ecto.Adapters.Postgres
end
