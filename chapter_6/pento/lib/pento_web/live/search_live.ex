defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Search
  alias Pento.Search.SearchEntry
  alias Pento.Catalog
  alias Pento.Catalog.Product

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:search_entry, %SearchEntry{})
      |> assign(:searched_products, [])
      |> clear_form()
    }
  end

  def clear_form(socket) do
    form =
      socket.assigns.search_entry
      |> Search.change_search_entry()
      |> to_form()

    assign(socket, :form, form)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def handle_event("validate", %{"search_entry" => search_entry_params}, %{assigns: %{search_entry: search_entry}} = socket) do
    changeset =
      search_entry
      |> Search.change_search_entry(search_entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("search", %{"search_entry" => search_entry_params}, %{assigns: %{search_entry: search_entry}} = socket) do
    {
      :noreply,
      socket
      |> assign(:searched_products, [Catalog.get_products_by_sku(search_entry_params["sku"])])
    }
  end
end
