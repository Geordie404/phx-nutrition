defmodule NutritionWeb.PageController do
  use NutritionWeb, :controller

  alias Nutrition.Food

  # prerender food items in the index

  def index(conn, _params) do
  items = Food.list_items()
    render(conn, "index.html", items: items)
  end
end
