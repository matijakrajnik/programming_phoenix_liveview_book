defmodule PentoWeb.GameInstructions.Show do
  use Phoenix.Component
  import Phoenix.HTML

  def instructions(assigns) do
  ~H"""
  <p>
    Fill whole board with pentominoes!
  </p>
  """
  end
end
