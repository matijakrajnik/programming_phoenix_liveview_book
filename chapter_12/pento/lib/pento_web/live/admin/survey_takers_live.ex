defmodule PentoWeb.Admin.SurveyTakersLive do
  use PentoWeb, :live_component
  alias PentoWeb.Presence

  def update(_assigns, socket) do
    {
      :ok,
      socket
      |> assign_survey_visitors()
    }
  end

  def assign_survey_visitors(socket) do
    assign(socket, :survey_visitors, Presence.list_survey_takers())
  end
end
