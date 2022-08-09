defmodule Nutrition.Food.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :calories, :integer
    field :carbohydrates, :integer
    field :fats, :integer
    field :food, :string
    field :proteins, :integer
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:username, :food, :calories, :proteins, :carbohydrates, :fats])
    |> validate_required([:username, :food, :calories, :proteins, :carbohydrates, :fats])
  end
end
