defmodule PentoWeb.SurveyLive do
  alias PentoWeb.SurveyLive.Component
  alias Pento.Survey
  alias PentoWeb.DemographicLive
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_demographic()
    }
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}}=socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end
end
