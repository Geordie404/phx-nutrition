defmodule NutritionWeb.MacroTrackerChannel do
  use NutritionWeb, :channel

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
    broadcast(socket, "shout-chat", payload)
    {:noreply, socket}
  end

  # Food box handler

  @impl true
  def handle_in("shout-food", payload, socket) do
    broadcast(socket, "shout-food", payload)
    {:noreply, socket}
  end

end
