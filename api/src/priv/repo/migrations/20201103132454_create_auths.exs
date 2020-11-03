defmodule Src.Repo.Migrations.CreateAuths do
  use Ecto.Migration

  def change do
    create table(:auths) do
      add :expire_date, :utc_datetime
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:auths, [:user_id])
  end
end
