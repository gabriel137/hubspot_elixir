defmodule HubspotApiWeb.OauthController do
  use HubspotApiWeb, :controller
  import HubspotClient
  require Logger

  @url "https://app.hubspot.com/oauth/authorize"
  @redirect_uri "http://localhost:4000/oauth-callback"

  def create(conn, _params) do
    Logger.info("uild the authorization URL to redirect a user.")

    client_id = Application.get_env(:hubspot_api, :client_id)
    scope = Application.get_env(:hubspot_api, :scope)

    auth_url = HubspotClient.Oauth.get_url_oauth(client_id, scope, @url, @redirect_uri) |> IO.inspect

    conn
    |> redirect(external: auth_url)
  end

  def callback(conn, %{"code" => code}) do
    Logger.info("Received an authorization token.")

    client_id = Application.get_env(:hubspot_api, :client_id)
    client_secret = Application.get_env(:hubspot_api, :client_secret)

    auth_code_prof = %{
      grant_type: "authorization_code",
      client_id: client_id,
      client_secret: client_secret,
      redirect_uri: @redirect_uri,
      code: code
    }

    tokens = HubspotClient.Oauth.exchange_for_token(auth_code_prof)

    conn
    |> renew_session()
    |> put_session(:token, tokens["access_token"])
    |> redirect(external: "/")
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end
end
