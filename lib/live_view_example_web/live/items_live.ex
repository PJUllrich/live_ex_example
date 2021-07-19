defmodule LiveViewExampleWeb.ItemsLive do
  use LiveViewExampleWeb, :live_view

  alias LiveViewExampleWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewExampleWeb.PageView, "items.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, Store.init(socket)}
  end

  defdelegate handle_info(msg, socket), to: Store
end
