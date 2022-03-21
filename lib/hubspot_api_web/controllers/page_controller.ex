defmodule HubspotApiWeb.PageController do
  use HubspotApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
