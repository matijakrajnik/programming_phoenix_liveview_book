defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    case conn.assigns.current_user do
      nil -> render(conn, :home, layout: false)
      _ ->   redirect(conn, to: "/guess")
    end
  end
end
