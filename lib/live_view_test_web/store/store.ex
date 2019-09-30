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
    filter: [],
    min_count: 0
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
    apply_filter(socket, :filter, filter)
  end

  def remove_filter(category_id, socket) do
    filter = Enum.filter(socket.assigns.filter, fn id -> id != category_id end)
    apply_filter(socket, :filter, filter)
  end

  def filter_by_count(count, socket) do
    count = if is_nil(count), do: 0, else: count
    apply_filter(socket, :min_count, count)
  end

  # Helpers

  defp apply_filter(socket, key, value) do
    socket = assign(socket, key, value)
    items = filter(socket)

    assign(socket, :items, items)
  end

  defp filter(socket) do
    category_filter =
      if socket.assigns.filter == [],
        do: Enum.map(socket.assigns.categories, & &1.id),
        else: socket.assigns.filter

    get_items()
    |> Enum.filter(&(&1.category_id in category_filter))
    |> Enum.filter(&(&1.count >= socket.assigns.min_count))
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
