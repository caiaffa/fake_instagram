defmodule FakeInstagram.Repo do
  use Ecto.Repo,
    otp_app: :fake_instagram,
    adapter: Ecto.Adapters.Postgres
end
