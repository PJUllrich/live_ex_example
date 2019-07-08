defmodule LiveViewTestWeb.ParentLive do
  use Phoenix.LiveView

  alias LiveViewTestWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "parent.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, Store.init(socket)}
  end

  def handle_event("toggle" = event, _value, socket) do
    Store.dispatch(event, socket)
    {:noreply, socket}
  end

  defdelegate handle_info(msg, socket), to: Store

end
