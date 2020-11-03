defmodule SrcWeb.AuthView do
  use SrcWeb, :view
  alias SrcWeb.AuthView

  def render("index.json", %{auths: auths}) do
    %{data: render_many(auths, AuthView, "auth.json")}
  end

  def render("show.json", %{auth: auth}) do
    %{data: render_one(auth, AuthView, "auth.json")}
  end

  def render("auth.json", %{auth: auth}) do
    %{id: auth.id,
      expire_date: auth.expire_date,
      token: auth.token}
  end
end
