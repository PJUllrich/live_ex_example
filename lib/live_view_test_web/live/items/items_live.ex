defmodule LiveViewTestWeb.ItemsLive do
  use Phoenix.LiveView

  alias LiveViewTestWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewTestWeb.PageView, "items.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, Store.init(socket)}
  end

  defdelegate handle_info(msg, socket), to: Store
end
