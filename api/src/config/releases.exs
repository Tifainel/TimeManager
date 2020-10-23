# File: my_app/config/releases.exs
import Config

db_host = System.get_env("DATABASE_HOST") || "db"
db_database = System.get_env("DATABASE_DB") || "src_dev"
db_username = System.get_env("DATABASE_USER") || "postgres"
db_password = System.get_env("DATABASE_PASSWORD") || "postgres"
db_url = "ecto://#{db_username}:#{db_password}@#{db_host}/#{db_database}"
config :my_app, Src.Repo,
  url:  db_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  secret_key_base = System.get_env("SECRET_KEY_BASE") || "Qnfc6g4wpfrtmRJWFEvk0d7Of3MnGUFZfgZO2rPaghF83bdtnGQDvxcZH+q4xE5B"
config :my_app, SrcWeb.Endpoint,
  http: [port: 4000],
  secret_key_base: secret_key_base
