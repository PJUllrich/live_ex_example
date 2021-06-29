defmodule LiveViewExampleWeb.CategoryLive do
  use LiveViewExampleWeb, :live_view

  alias LiveViewExampleWeb.Store

  @use_store_attributes ~w(topic filter categories)

  def render(assigns) do
    Phoenix.View.render(LiveViewExampleWeb.PageView, "category.html", assigns)
  end

  def mount(_params, session, socket) do
    attrs =
      session
      |> Map.take(@use_store_attributes)
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    {:ok, assign(socket, attrs)}
  end

  def handle_event(
        "filter_by_category",
        %{"cat-id" => cat_id},
        socket
      ) do
    category_id = String.to_integer(cat_id)
    Store.dispatch("filter_by_category", category_id, socket)
    {:noreply, socket}
  end
end
