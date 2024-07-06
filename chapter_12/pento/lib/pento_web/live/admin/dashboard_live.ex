defmodule PentoWeb.Admin.DashboardLive do
  use PentoWeb, :live_view
  alias PentoWeb.Endpoint
  alias PentoWeb.Admin.{SurveyResultsLive, UserActivityLive, SurveyTakersLive}

  @survey_results_topic "survey_results"
  @user_activity_topic "user_activity"
  @survey_takers_topic "survey_takers"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@survey_results_topic)
      Endpoint.subscribe(@user_activity_topic)
      Endpoint.subscribe(@survey_takers_topic)
    end
    {
      :ok,
      socket
      |> assign(:survey_results_component_id, "survey-results")
      |> assign(:user_activity_component_id, "user-activity")
      |> assign(:survey_takers_component_id, "survey-takers")
    }
  end

  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "survey_visited"}, socket) do
    send_update(
      SurveyTakersLive,
      id: socket.assigns.survey_takers_component_id
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff", payload: diff}, socket) do
    Endpoint.broadcast(@survey_takers_topic, "survey_visited", socket.assigns.current_user.email)
    {:noreply, socket}
  end
end
