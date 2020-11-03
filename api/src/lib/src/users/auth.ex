defmodule Src.Users.Auth do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auths" do
    field :expire_date, :utc_datetime
    field :token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(auth, attrs) do
    auth
    |> cast(attrs, [:expire_date, :token])
    |> validate_required([:expire_date, :token])
  end
end
