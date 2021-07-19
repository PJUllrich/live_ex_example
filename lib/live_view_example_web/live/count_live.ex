defmodule LiveViewExampleWeb.CountLive do
  use LiveViewExampleWeb, :live_view

  alias LiveViewExampleWeb.Store

  def render(assigns) do
    Phoenix.View.render(LiveViewExampleWeb.PageView, "count.html", assigns)
  end

  def mount(_params, %{"live_ex_store_pid" => live_ex_store_pid} = _session, socket) do
    socket =
      socket
      |> assign(:live_ex_store_pid, live_ex_store_pid)
      |> Store.init()

    {:ok, socket}
  end

  def handle_event(
        "filter_by_count" = event,
        %{"count" => count},
        %{assigns: %{live_ex_store_pid: store_pid}} = socket
      ) do
    count =
      case Integer.parse(count) do
        {count, _rem} -> count
        :error -> nil
      end

    Store.dispatch(store_pid, event, count, socket)
    {:noreply, socket}
  end

  # Let the LiveEx-Store handle any state changes.
  defdelegate handle_info(msg, socket), to: Store
end
