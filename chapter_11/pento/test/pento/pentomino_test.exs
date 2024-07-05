defmodule Pento.PentominoTest do
  use Pento.DataCase
  alias Pento.Game.{Shape, Pentomino}

  @pentomino_fields [
    name: :l,
    rotation: 0,
    reflected: false,
    location: {5, 5}
  ]

  defp create_pentomino(_) do
    %{pentomino: Pentomino.new(@pentomino_fields)}
  end

  describe "pentomino" do
    setup [:create_pentomino]

    test "new" do
      assert Pentomino.new(@pentomino_fields) == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 5}
      }
    end

    test "rotate", %{pentomino: pentomino} do
      pentomino = Pentomino.rotate(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 90,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 180,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 270,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 5}
      }
    end

    test "rotate counter clockwise", %{pentomino: pentomino} do
      pentomino = Pentomino.rotate(pentomino, :counter_clockwise)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 270,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino, :counter_clockwise)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 180,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino, :counter_clockwise)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 90,
        reflected: false,
        location: {5, 5}
      }

      pentomino = Pentomino.rotate(pentomino, :counter_clockwise)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 5}
      }
    end

    test "flip", %{pentomino: pentomino} do
      pentomino = Pentomino.flip(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: true,
        location: {5, 5}
      }

      pentomino = Pentomino.flip(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 5}
      }
    end

    test "up", %{pentomino: pentomino} do
      pentomino = Pentomino.up(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 4}
      }
    end

    test "down", %{pentomino: pentomino} do
      pentomino = Pentomino.down(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {5, 6}
      }
    end

    test "left", %{pentomino: pentomino} do
      pentomino = Pentomino.left(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {4, 5}
      }
    end

    test "right", %{pentomino: pentomino} do
      pentomino = Pentomino.right(pentomino)
      assert pentomino == %Pentomino{
        name: :l,
        rotation: 0,
        reflected: false,
        location: {6, 5}
      }
    end

    test "to_shape", %{pentomino: pentomino} do
      shape = Pentomino.to_shape(pentomino)
      assert shape == %Shape{
        color: :green,
        name: :l,
        points: [{5, 3}, {5, 4}, {5, 5}, {5, 6}, {6, 6}]
      }
    end
  end
end
