defmodule Pento.ShapeTest do
  use Pento.DataCase
  alias Pento.Game.Shape

  describe "shape" do
    test "new" do
      assert Shape.new(:l, 270, true, {5, 5}) == %Shape{
        color: :green,
        name: :l,
        points: [{3, 5}, {4, 5}, {5, 5}, {6, 5}, {6, 6}]
      }
    end
  end
end
