defmodule FakeInstagramWeb.Authentication do
  alias FakeInstagramWeb.Oauth
  alias FakeInstagram.Accounts

  def login(token, "facebook") do
    attrs = Oauth.Facebook.get_info(token)

    search_params = %{facebook_id: attrs.facebook_id, email: attrs.email}

    Accounts.get_user_or_create(attrs, search_params)
  end
end
