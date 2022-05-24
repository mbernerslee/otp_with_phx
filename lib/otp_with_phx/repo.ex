defmodule OtpWithPhx.Repo do
  use Ecto.Repo,
    otp_app: :otp_with_phx,
    adapter: Ecto.Adapters.Postgres
end
