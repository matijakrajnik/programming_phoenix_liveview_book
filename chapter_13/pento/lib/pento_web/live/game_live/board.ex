defmodule PentoWeb.GameLive.Board do
  use PentoWeb, :live_component
  alias Pento.Game
  import PentoWeb.GameLive.{Colors, Component}

  def render(assigns) do
    ~H"""
    <div id={ @id } phx-window-keydown="key" phx-target={ @myself }>
      <p class="font-heavy text-2xl">Score: <%= @score %></p>
      <.canvas view_box="0 0 200 70">
        <%= for shape <- @shapes do %>
          <.shape
            points={ shape.points }
            fill= { color(shape.color, Game.shape_active?(@board, shape.name), false) }
            name={ shape.name } />
        <% end %>
      </.canvas>
      <hr/>
      <.palette
        shape_names={@board.palette}
        completed_shape_names={ Enum.map(@board.completed_pentos, & &1.name) } />
      <.button phx-target={ @myself } phx-click="give up">Give up</.button>
    </div>
    """
  end

  def update(%{puzzle: puzzle, id: id, score: score}, socket) do
    {
      :ok,
      socket
      |> assign_params(id, puzzle, score)
      |> assign_board()
      |> assign_shapes()
    }
  end

  def assign_params(socket, id, puzzle, score) do
    assign(socket, id: id, puzzle: puzzle, score: score)
  end

  def assign_board(%{assigns: %{puzzle: puzzle}} = socket) do
    board =
      puzzle
      |> String.to_existing_atom
      |> Game.create_board

    assign(socket, board: board)
  end

  def assign_shapes(%{assigns: %{board: board}} = socket) do
    shapes = Game.convert_board_to_shapes(board)
    assign(socket, shapes: shapes)
  end

  def assign_score(%{assigns: %{score: score}} = socket) do
    assign(socket, score: score)
  end

  def handle_event("pick", %{"name" => name}, socket) do
    {:noreply, socket |> pick(name) |> assign_shapes}
  end

  def handle_event("key", %{"key" => key}, socket) do
    {:noreply, socket |> do_key(key) |> assign_shapes}
  end

  def handle_event("give up", _params, socket) do
    {:noreply, socket |> reset_board}
  end

  defp pick(socket, name) do
    shape_name = String.to_existing_atom(name)
    update(socket, :board, &Game.pick_shape(&1, shape_name))
  end

  def do_key(socket, key) do
    case key do
      " " -> drop(socket)
      "ArrowLeft" -> move(socket, :left)
      "ArrowRight" -> move(socket, :right)
      "ArrowUp" -> move(socket, :up)
      "ArrowDown" -> move(socket, :down)
      "Shift" -> move(socket, :rotate)
      "Enter" -> move(socket, :flip)
      "Space" -> drop(socket)
      _ -> socket
    end
  end

  def move(socket, move) do
    case Game.maybe_move(socket.assigns.board, move) do
      {:error, message} ->
        put_flash(socket, :info, message)
      {:ok, board} ->
        socket |> assign(board: board) |> assign_shapes |> update_score(-1)
    end
  end

  defp drop(socket) do
    case Game.maybe_drop(socket.assigns.board) do
      {:error, message} ->
        put_flash(socket, :info, message)
      {:ok, board} ->
        socket
          |> assign(board: board)
          |> assign_shapes
          |> update_score(500)
          |> redirect_if_won
    end
  end

  defp update_score(socket, score_points) do
    update(socket, :score, &Kernel.+(&1, score_points))
  end

  defp redirect_if_won(%{assigns: %{board: board, score: score}} = socket) do
    if Enum.count(board.palette) == Enum.count(board.completed_pentos),
      do: push_navigate(socket, to: "/game_won?score=#{score}") |> IO.inspect,
      else: socket
  end

  defp reset_board(socket) do
    socket
      |> assign_board
      |> assign_shapes
      |> assign(score: 0)
  end
end
