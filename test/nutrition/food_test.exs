defmodule Nutrition.FoodTest do
  use Nutrition.DataCase

  alias Nutrition.Food

  describe "items" do
    alias Nutrition.Food.Item

    import Nutrition.FoodFixtures

    @invalid_attrs %{calories: nil, carbohydrates: nil, fats: nil, food: nil, proteins: nil, username: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Food.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Food.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{calories: 42, carbohydrates: 42, fats: 42, food: "some food", proteins: 42, username: "some username"}

      assert {:ok, %Item{} = item} = Food.create_item(valid_attrs)
      assert item.calories == 42
      assert item.carbohydrates == 42
      assert item.fats == 42
      assert item.food == "some food"
      assert item.proteins == 42
      assert item.username == "some username"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{calories: 43, carbohydrates: 43, fats: 43, food: "some updated food", proteins: 43, username: "some updated username"}

      assert {:ok, %Item{} = item} = Food.update_item(item, update_attrs)
      assert item.calories == 43
      assert item.carbohydrates == 43
      assert item.fats == 43
      assert item.food == "some updated food"
      assert item.proteins == 43
      assert item.username == "some updated username"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Food.update_item(item, @invalid_attrs)
      assert item == Food.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Food.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Food.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Food.change_item(item)
    end
  end
end
