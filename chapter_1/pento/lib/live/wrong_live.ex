defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:")}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1> <h2>
        <%= @message %>
      </h2>
    <br/> <h2>
        <%= for n <- 1..10 do %>
          <.link class="bg-emerald-50 hover:bg-blue-700
          text-rose-900 font-bold py-2 px-4 border border-gray-300 rounded m-1"
          phx-click="guess" phx-value-number= {n} >
            <%= n %>
          </.link>
        <% end %>
      </h2>
    """
  end
end
