defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    winning_number = Enum.random(1..10)
    {
      :ok,
      assign(
        socket,
        score: 0,
        winning_number: winning_number,
        message: "Make a guess:"
      )
    }
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= time() %>
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link class="bg-emerald-50 hover:bg-blue-700
        text-rose-900 font-bold py-2 px-4 border border-gray-300 rounded m-1"
        phx-click="guess" phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    <br/>
    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score} = if String.to_integer(guess) != socket.assigns.winning_number do
      {"Your guess: #{guess}. Wrong. Guess again. ", socket.assigns.score - 1}
    else
      {"Your guess: #{guess}. Correct, you win. ", socket.assigns.score + 1}
    end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end
end
