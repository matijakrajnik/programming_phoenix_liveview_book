defmodule PentoWeb.RatingLiveTest do
  use PentoWeb.ConnCase
  import Phoenix.LiveViewTest
  alias Pento.{Accounts, Survey, Catalog}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }

  @create_user_attrs %{
    email: "test@test.com",
    password: "passwordpassword"
  }

  @create_demographic_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now.year - 15,
    education_level: "high school"
  }

  defp product_fixture do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

  defp user_fixture(attrs \\ @create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp demographic_fixture(user, attrs \\ @create_demographic_attrs) do
    attrs =
      attrs
      |> Map.merge(%{user_id: user.id})
    {:ok, demographic} = Survey.create_demographic(attrs)
    demographic
  end

  defp rating_fixture(user, product, stars) do
    {:ok, rating} = Survey.create_rating(%{
      stars: stars,
      user_id: user.id,
      product_id: product.id
    })
    rating
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_rating(user, product, stars) do
    rating = rating_fixture(user, product, stars)
    %{rating: rating}
  end

  defp create_demographic(user) do
    demographic = demographic_fixture(user)
    %{demographic: demographic}
  end

  describe "Rating Index" do
    setup [:register_and_log_in_user, :create_product, :create_user]

    setup %{user: user, product: product} do
      create_demographic(user)
      :ok
    end

    test "it renders form when there is no product rating", %{conn: conn, user: user} do
      products = Catalog.list_products_with_user_rating(user)
      {:ok, view, _html} = live(conn, "/products")
      assert render_component(&PentoWeb.RatingLive.Index.product_list/1, products: products, current_user: user) =~ "rating-form-#{Enum.at(products, 0).id}"
    end

    test "it renders rating when it exists", %{conn: conn, user: user, product: product} do
      create_rating(user, product, 3)
      products = Catalog.list_products_with_user_rating(user)
      {:ok, view, _html} = live(conn, "/products")
      assert render_component(&PentoWeb.RatingLive.Index.product_list/1, products: products, current_user: user) =~ "&#x2605; &#x2605; &#x2605; &#x2606; &#x2606;"
    end
  end
end
