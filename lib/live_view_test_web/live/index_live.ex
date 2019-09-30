defmodule LiveViewTestWeb.IndexLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :view, 0)}
  end

  def handle_event("change_view", %{"index" => index}, socket) do
    {:noreply, assign(socket, :view, String.to_integer(index))}
  end
end
