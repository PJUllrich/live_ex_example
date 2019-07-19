defmodule LiveViewTestWeb.TableLive do
  use Phoenix.LiveView

  alias LiveViewTestWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "table.html", assigns)
  end

  def mount(session, socket) do
    {:ok, Store.init(session, socket)}
  end

  def handle_event("filter_by_count" = event, %{"count" => count}, socket) do
    count =
      case Integer.parse(count) do
        {count, _rem} -> count
        :error -> nil
      end

    Store.dispatch(event, count, socket)
    {:noreply, socket}
  end
end
