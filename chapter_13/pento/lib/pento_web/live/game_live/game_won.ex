defmodule PentoWeb.GameLive.GameWon do
  use PentoWeb, :live_view

  def mount(%{"score" => score}, _session, socket) do
    {
      :ok,
      socket
      |> assign(score: score)
    }
  end

  def render(assigns) do
    ~H"""
    <div>
      <p>Congratulations, you won!</p>
      <p>Score: <%= @score %></p>
    </div>
    """
  end
end
