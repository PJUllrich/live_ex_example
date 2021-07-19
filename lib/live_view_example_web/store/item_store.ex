defmodule LiveViewExampleWeb.Store do
  @moduledoc """
  A Vuex-inspired Flux Store for managing the State of a Phoenix LiveView application.
  """

  use LiveEx

  @all_items [
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

  @initial_state %{
    items: @all_items,
    categories: [
      %{id: 1, name: "House"},
      %{id: 2, name: "Office"},
      %{id: 3, name: "Car"},
      %{id: 4, name: "General"}
    ],
    filter: [],
    min_count: 0
  }

  def init(socket) do
    init(@initial_state, socket)
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
    broadcast_state_change(socket, :filter, filter)
    apply_filter(:filter, filter, socket)
  end

  def remove_filter(category_id, socket) do
    filter = Enum.filter(socket.assigns.filter, fn id -> id != category_id end)
    broadcast_state_change(socket, :filter, filter)
    apply_filter(:filter, filter, socket)
  end

  def filter_by_count(count, socket) do
    count = if is_nil(count), do: 0, else: count
    broadcast_state_change(socket, :min_count, count)
    apply_filter(:min_count, count, socket)
  end

  # Helpers

  def apply_filter(key, value, socket) do
    socket = assign(socket, key, value)
    items = filter(socket)

    assign(socket, :items, items)
  end

  defp filter(%{assigns: %{filter: filter, min_count: min_count}} = socket) do
    category_filter =
      if filter == [],
        do: Enum.map(socket.assigns.categories, & &1.id),
        else: filter

    @all_items
    |> Enum.filter(&(&1.category_id in category_filter))
    |> Enum.filter(&(&1.count >= min_count))
  end
end
