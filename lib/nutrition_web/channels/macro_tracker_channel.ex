defmodule NutritionWeb.MacroTrackerChannel do
  use NutritionWeb, :channel

  alias Nutrition.Chats
  alias Nutrition.Food

  @impl true
  def join("macro_tracker:lobby", _payload, socket) do
    {:ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (macro_tracker:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Chat message box handler

  @impl true
  def handle_in("shout-chat", payload, socket) do
    Chats.create_message(payload)
    |> case do
      {:ok, _} ->
        Chats.list_messages
        |> message_display("shout-chat", socket)
    {:noreply, socket}
    end
  end

  defp message_display(messages, shout, socket) do
    messages
    |> Enum.each(fn message -> push(socket, shout, %{
        name: message.name,
        body: message.body
      }) end)
  end


  # Food box handler

  @impl true
  def handle_in("shout-food", payload, socket) do
    Food.create_item(payload)
    |> case do
      {:ok, _} ->
        Food.list_items
        |> food_display("shout-food", socket)
    {:noreply, socket}
    end
  end

  defp food_display(items, shout, socket) do
    items
    |> Enum.each(fn item -> push(socket, shout, %{
        username: item.username,
        food: item.food,
        calories: item.calories,
        proteins: item.proteins,
        carbohydrates: item.carbohydrates,
        fats: item.fats
      }) end)
  end

end
