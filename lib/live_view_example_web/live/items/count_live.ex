defmodule LiveViewExampleWeb.CountLive do
  use LiveViewExampleWeb, :live_view

  alias LiveViewExampleWeb.Store

  @use_store_attributes ~w(topic filter min_count)

  def render(assigns) do
    Phoenix.View.render(LiveViewExampleWeb.PageView, "count.html", assigns)
  end

  def mount(_params, session, socket) do
    attrs =
      session
      |> Map.take(@use_store_attributes)
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    {:ok, assign(socket, attrs)}
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
