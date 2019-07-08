defmodule LiveViewTestWeb.Store do
  @moduledoc """
  A Vuex-inspired Flux Store for managing the State of a Phoenix LiveView application.
  """

  use Phoenix.LiveView

  @initial_state %{
    toggle: false
  }

  @doc """
  Configures the socket with an initial setup.

  The `pid` of the parent process is stored in the `socket.assigns` so that
  Child processes can dispatch Actions on the parents's Store.
  """
  def init(socket) do
    socket
    |> assign(:state, @initial_state)
    |> assign(:pid, self())
  end

  @doc """
  Joins a child process to the Store of a parent process.
  """
  def join(params, socket) do
    socket
    |> assign(:state, params.state)
    |> assign(:pid, params.pid)
  end

  @doc """
  Dispatch an Action with an `event`-type, optional payload, and a LiveView Socket.
  """
  def dispatch(event, payload \\ %{}, socket) do
    event = %{
      action: String.to_atom(event),
      payload: payload
    }
    send(socket.assigns.pid, event)
  end

  defp commit(event, socket) do
    apply(__MODULE__, event.action, [socket, event.payload])
  end

  defp mutate(mutation, socket) do
    new_state = Map.merge(socket.assigns.state, mutation)
    assign(socket, :state, new_state)
  end

  # ACTIONS

  @doc """
  Handles the :toggle Action. Put any business or async Logic here before
  calling the `commit` function, which commits the Mutation.
  """
  def handle_info(%{action: :toggle} = event, socket) do
    socket = commit(event, socket)
    {:noreply, socket}
  end

  # MUTATIONS

  @doc """
  Handles the :toggle Mutation. Toggles the variable state.toggle from
  `true` to `false` and vice versa.
  """
  def toggle(socket, _args) do
    mutation = %{toggle: !socket.assigns.state.toggle}
    mutate(mutation, socket)
  end
end
