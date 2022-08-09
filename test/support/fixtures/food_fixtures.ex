defmodule Nutrition.FoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Nutrition.Food` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        calories: 42,
        carbohydrates: 42,
        fats: 42,
        food: "some food",
        proteins: 42,
        username: "some username"
      })
      |> Nutrition.Food.create_item()

    item
  end
end
