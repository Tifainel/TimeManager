# assign a default for the database_user
DB_USER=${DATABASE_USER:-postgres}

# wait until Postgres is ready
while ! pg_isready -d src_dev -h db -p 5432 -U postgres -q
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/app/bin/src"
eval "$bin eval \"SrcWeb.Release.create_db_for\""
eval "$bin eval \"SrcWeb.Release.migrate\""
echo "coucou"
eval "$bin" "start"
echo "started!!"