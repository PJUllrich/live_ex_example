defmodule LiveViewExampleWeb.CategoryLive do
  use LiveViewExampleWeb, :live_view

  require Logger

  alias LiveViewExampleWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewExampleWeb.PageView, "category.html", assigns)
  end

  def mount(_params, %{"live_ex_store_pid" => live_ex_store_pid} = _session, socket) do
    socket =
      socket
      |> assign(:live_ex_store_pid, live_ex_store_pid)
      |> Store.init()

    {:ok, socket}
  end

  def handle_event(
        "filter_by_category",
        %{"cat-id" => cat_id},
        %{assigns: %{live_ex_store_pid: store_pid}} = socket
      ) do
    category_id = String.to_integer(cat_id)
    Store.dispatch(store_pid, "filter_by_category", category_id, socket)
    {:noreply, socket}
  end

  def handle_info({:update_state, key, new_state} = msg, socket) do
    # Do something before actually updating the state here.
    Logger.debug("CategoryLive received new state for #{key} = #{inspect(new_state)}")
    Store.handle_info(msg, socket)
  end
end
