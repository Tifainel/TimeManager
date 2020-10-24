# File: my_app/Dockerfile
FROM node:10.22.1-alpine3.11 as build_front

WORKDIR /src
COPY front /src

ENV OUTPUT_DIR=/src/build

RUN npm install
RUN npm run build

RUN ls /src/build

FROM elixir:1.9-alpine as build_api

RUN apk add --update git build-base nodejs npm

RUN mkdir /app
WORKDIR /app

# copy api code
COPY api/src/mix.exs api/src/mix.lock ./
COPY api/src/config config
COPY api/src/priv priv
COPY api/src/lib lib

# copy frontend assets
COPY --from=build_front /src/build priv/static

RUN ls priv/static

# set build ENV
ENV MIX_ENV=prod

# install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# install mix dependencies
RUN mix deps.get --only $MIX_ENV

# build project
RUN mix compile

# build assets
RUN mix phx.digest

# build release
RUN mix release

# prepare release image
FROM alpine:3.9 AS app

# install runtime dependencies
RUN apk add --update openssl postgresql-client

ENV MIX_ENV=prod

# prepare app directory
RUN mkdir /app
WORKDIR /app

# copy release to app container
COPY --from=build_api /app/_build/prod/rel/src .

# copy entrypoint & make it executable
COPY entrypoint.sh .
RUN chmod +x /app/entrypoint.sh

ENV HOME=/app
ENV APP_BIN=/app/bin/src

CMD ["/app/entrypoint.sh"]