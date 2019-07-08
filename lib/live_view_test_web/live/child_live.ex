defmodule LiveViewTestWeb.ChildLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "child.html", assigns)
  end

  def mount(params, socket) do
    {:ok, assign(socket, :state, params.state)}
  end

  def handle_event("toggle_state", _value, socket) do
    {:noreply, assign(socket, :state, !socket.assigns.state)}
  end
end
