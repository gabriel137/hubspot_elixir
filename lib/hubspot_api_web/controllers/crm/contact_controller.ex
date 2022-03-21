defmodule HubspotApiWeb.ContactController do
  use HubspotApiWeb, :controller

  import HubspotClient
  require Logger

  def index(conn, params) do
    contatos = %{nome: "Gabriel Cardoso", telefone: "(027) 99638-7850"}

    get_all_contacts |> IO.inspect

    render(conn, "index.html", contatos: contatos)
  end

  def get_all_contacts do
    Logger.info("Get all contacts.")

    Application.get_env(:hubspot_api, :token_api)
    |> HubspotClient.Contacts.client
    |> HubspotClient.Contacts.get_all_contacts
  end


end
