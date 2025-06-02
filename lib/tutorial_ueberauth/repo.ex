defmodule TutorialUeberauth.Repo do
  use Ecto.Repo,
    otp_app: :tutorial_ueberauth,
    adapter: Ecto.Adapters.Postgres
end
