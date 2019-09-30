defmodule LiveViewTestWeb.CategoryLive do
  use Phoenix.LiveView

  alias LiveViewTestWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "category.html", assigns)
  end

  def mount(session, socket) do
    {:ok, Store.init(session, socket)}
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
