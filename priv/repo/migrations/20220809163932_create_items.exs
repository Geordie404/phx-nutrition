defmodule Nutrition.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :username, :string
      add :food, :string
      add :calories, :integer
      add :proteins, :integer
      add :carbohydrates, :integer
      add :fats, :integer

      timestamps()
    end
  end
end
