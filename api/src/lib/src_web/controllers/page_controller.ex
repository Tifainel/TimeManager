defmodule SrcWeb.PageController do
  use SrcWeb, :controller

  def index(conn, _params) do
    html(conn, File.read!(Path.join(:code.priv_dir(:src), "static/index.html")))
  end

  def index_dev(conn, _params) do
    redirect(conn, external: "http://localhost:8080#{current_path(conn)}")
  end
end
