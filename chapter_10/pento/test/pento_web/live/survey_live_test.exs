defmodule PentoWeb.SurveyLiveTest do
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

  describe "demographic form" do
    setup [:register_and_log_in_user, :create_product, :create_user]

    test "refresh page with new data on submit", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/survey")
      params = %{
        "demographic[gender]" => "male",
        "demographic[year_of_birth]" => Integer.to_string(DateTime.utc_now.year - 25),
        "demographic[education_level]" => "other"
      }

      # assert view
      #   |> element("#demographic-form")
      #   |> render_submit(params) =~ "Demographic created successfully"
    end
  end
end
