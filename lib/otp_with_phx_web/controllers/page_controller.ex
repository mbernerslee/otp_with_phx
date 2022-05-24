defmodule OtpWithPhxWeb.PageController do
  use OtpWithPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
