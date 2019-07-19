defmodule LiveViewTestWeb.ViewLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "view.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :view, 0)}
  end

  def handle_event("change_view", value, socket) do
    {:noreply, assign(socket, :view, String.to_integer(value))}
  end
end
