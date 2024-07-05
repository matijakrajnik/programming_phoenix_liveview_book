defmodule Pento.PointTest do
  use Pento.DataCase
  alias Pento.Game.Point

  @point_coords {1, 2}

  defp create_point(_) do
    {x, y} = @point_coords
    %{point: Point.new(x, y)}
  end

  describe "point" do
    setup [:create_point]

    test "new" do
      assert Point.new(3, 4) == {3, 4}
    end

    test "move", %{point: point} do
      assert Point.move(point, {3, 2}) == {4, 4}
    end

    test "transpose", %{point: point} do
      assert Point.transpose(point) == {2, 1}
    end

    test "flip", %{point: point} do
      assert Point.flip(point) == {1, 4}
    end

    test "reflect", %{point: point} do
      assert Point.reflect(point) == {5, 2}
    end

    test "rotate 0", %{point: point} do
      assert Point.rotate(point, 0) == {1, 2}
    end

    test "rotate 90", %{point: point} do
      assert Point.rotate(point, 90) == {2, 5}
    end

    test "rotate 180", %{point: point} do
      assert Point.rotate(point, 180) == {5, 4}
    end

    test "rotate 270", %{point: point} do
      assert Point.rotate(point, 270) == {4, 1}
    end

    test "center", %{point: point} do
      assert point
        |> Point.move({3, 3})
        |> Point.center() == {1, 2}
    end

    test "maybe reflect true", %{point: point} do
      assert Point.maybe_reflect(point, true) == {5, 2}
    end

    test "maybe reflect false", %{point: point} do
      assert Point.maybe_reflect(point, false) == {1, 2}
    end

    test "prepare", %{point: point} do
      assert Point.prepare(point, 180, true, {5, 5}) == {3, 6}
    end
  end
end
