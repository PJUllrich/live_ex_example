defmodule LiveViewExampleWeb.IndexLive do
  use LiveViewExampleWeb, :live_view

  @impl true
  def render(assigns) do
    LiveViewExampleWeb.PageView.render("index.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, view: 0)}
  end

  @impl true
  def handle_event("change_view", %{"index" => index}, socket) do
    {:noreply, assign(socket, :view, String.to_integer(index))}
  end
end
