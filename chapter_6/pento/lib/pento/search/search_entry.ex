defmodule Pento.Search.SearchEntry do
  defstruct [:sku]
  @types %{sku: :integer}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = searched, attrs) do
    {searched, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:sku])
    |> validate_number(:sku, greater_than: 100)
  end
end
