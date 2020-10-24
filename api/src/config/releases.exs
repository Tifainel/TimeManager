# File: my_app/config/releases.exs
import Config

config :src, Src.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = System.get_env("SECRET_KEY_BASE") || "Qnfc6g4wpfrtmRJWFEvk0d7Of3MnGUFZfgZO2rPaghF83bdtnGQDvxcZH+q4xE5B"

config :src, SrcWeb.Endpoint,
  http: [port: System.get_env("PORT")],
  secret_key_base: secret_key_base
