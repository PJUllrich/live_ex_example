defmodule LiveViewTestWeb.ParentLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "parent.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, assign(socket, :state, false)}
  end

  def handle_event("toggle_state", _value, socket) do
    {:noreply, assign(socket, :state, !socket.assigns.state)}
  end
end
