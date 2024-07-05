defmodule Pento.BoardTest do
  use Pento.DataCase
  alias Pento.Game.{Shape, Board}

  def create_board(_) do
    %{board: Board.new(:default)}
  end

  describe "board" do
    setup [:create_board]

    defp rect(x, y) do
      for x <- 1..x, y <- 1..y, do: {x, y}
    end

    test "new tiny" do
      assert Board.new(:tiny) == %Board{
        active_pento: nil,
        completed_pentos: [],
        palette: [:u, :v, :p],
        points: rect(5, 3)
      }
    end

    test "new widest" do
      assert Board.new(:widest) == %Board{
        active_pento: nil,
        completed_pentos: [],
        palette: [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t],
        points: rect(20, 3)
      }
    end

    test "new wide" do
      assert Board.new(:wide) == %Board{
        active_pento: nil,
        completed_pentos: [],
        palette: [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t],
        points: rect(15, 4)
      }
    end

    test "new medium" do
      assert Board.new(:medium) == %Board{
        active_pento: nil,
        completed_pentos: [],
        palette: [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t],
        points: rect(12, 5)
      }
    end

    test "new default" do
      assert Board.new(:default) == %Board{
        active_pento: nil,
        completed_pentos: [],
        palette: [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t],
        points: rect(10, 6)
      }
    end

    test "to shape", %{board: board} do
      assert Board.to_shape(board) == %Shape{
        color: :purple,
        name: :board,
        points: board.points
      }
    end

    test "to shapes", %{board: board} do
      assert Board.to_shapes(board) == [
        %Shape{
          color: :purple,
          name: :board,
          points: board.points
        }
      ]
    end
  end
end
