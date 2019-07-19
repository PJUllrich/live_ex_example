defmodule LiveViewTestWeb.Store do
  @moduledoc """
  A Vuex-inspired Flux Store for managing the State of a Phoenix LiveView application.
  """

  use LiveEx

  @behaviour LiveEx
  @type socket :: Phoenix.LiveView.Socket.t()

  @initial_state %{
    items: [],
    categories: [],
    filter: []
  }

  def init(socket) do
    state = Map.merge(@initial_state, %{items: get_items(), categories: get_categories()})
    init(state, socket)
  end

  # Actions

  def handle_info(%{type: "filter_by_category"} = action, socket) do
    if action.payload in socket.assigns.filter do
      commit(:remove_filter, action.payload, socket)
    else
      commit(:add_filter, action.payload, socket)
    end
  end

  def handle_info(%{type: "filter_by_count"} = action, socket) do
    commit(:filter_by_count, action.payload, socket)
  end

  # Mutations

  def add_filter(category_id, socket) do
    filter = socket.assigns.filter ++ [category_id]
    items = filter(filter)

    socket
    |> assign(:items, items)
    |> assign(:filter, filter)
  end

  def remove_filter(category_id, socket) do
    filter = Enum.filter(socket.assigns.filter, fn id -> id != category_id end)
    items = filter(filter)

    socket
    |> assign(:items, items)
    |> assign(:filter, filter)
  end

  def filter_by_count(count, socket) do
    items =
      if !is_nil(count) do
        Enum.filter(get_items(), fn item -> item.count >= count end)
      else
        get_items()
      end

    assign(socket, :items, items)
  end

  # Helpers

  defp filter(filter) do
    if length(filter) > 0 do
      Enum.filter(get_items(), fn item -> item.category_id in filter end)
    else
      get_items()
    end
  end

  defp get_items do
    [
      %{name: "Spoon", count: 5, category_id: 1},
      %{name: "Fork", count: 5, category_id: 1},
      %{name: "Couch", count: 1, category_id: 1},
      %{name: "Laptop", count: 1, category_id: 2},
      %{name: "Coffee Machine", count: 1, category_id: 2},
      %{name: "Fire Extinguisher", count: 1, category_id: 3},
      %{name: "Safety Vest", count: 2, category_id: 3},
      %{name: "Friends", count: 0, category_id: 3},
      %{name: "Wheels", count: 5, category_id: 3},
      %{name: "Suitcase", count: 1, category_id: 4},
      %{name: "Kindle", count: 1, category_id: 4},
      %{name: "Pair of Shoes", count: 7, category_id: 4}
    ]
  end

  defp get_categories do
    [
      %{id: 1, name: "House"},
      %{id: 2, name: "Office"},
      %{id: 3, name: "Car"},
      %{id: 4, name: "General"}
    ]
  end
end
