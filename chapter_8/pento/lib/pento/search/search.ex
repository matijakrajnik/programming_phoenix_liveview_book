defmodule Pento.Search do
  alias Pento.Search.SearchEntry

  def change_search_entry(%SearchEntry{} = search_entry, attrs \\ %{}) do
    SearchEntry.changeset(search_entry, attrs)
  end
end
