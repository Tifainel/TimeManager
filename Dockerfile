# File: my_app/Dockerfile
FROM node:10.22.1-alpine3.11 as build_front

WORKDIR /src
COPY front /src

ENV OUTPUT_DIR=/src/build

RUN apk add git
RUN npm install
RUN npm run build
RUN ls /src/build

FROM node:10.15.3-alpine as build_mobile

WORKDIR /src
COPY mobile-app /src

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_VERSION 4.4
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${GRADLE_HOME}/bin:${JAVA_HOME}/bin:${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN apk update && apk add curl openjdk8-jre openjdk8
RUN npm i
RUN mkdir -p ${GRADLE_HOME} && \
  curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip > /tmp/gradle.zip && \
  unzip /tmp/gradle.zip -d ${GRADLE_HOME} && \
  mv ${GRADLE_HOME}/gradle-${GRADLE_VERSION}/* ${GRADLE_HOME} && \
  rm -r ${GRADLE_HOME}/gradle-${GRADLE_VERSION}/

RUN mkdir -p ${ANDROID_HOME} && \
  curl -L https://dl.google.com/android/repository/tools_r25.2.5-linux.zip > /tmp/tools.zip && \
  unzip /tmp/tools.zip -d ${ANDROID_HOME}

RUN echo y | android update sdk --no-ui -a --filter platform-tools,android-26,build-tools-26.0.2

# Make license agreement
RUN mkdir $ANDROID_HOME/licenses && \
    echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license && \
    echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license && \
    echo 24333f8a63b6825ea9c5514f83c2829b004d1fee >> $ANDROID_HOME/licenses/android-sdk-license && \
    echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

RUN rm -rf /tmp/* /var/cache/apk/*
#Accept license and update android-sdk to API 23
# RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-23.0.3,android-23

RUN rm -rf /src/www/*
COPY --from=build_front /src/build www

CMD cordova build android

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
RUN mkdir priv/static/apk
COPY --from=build_mobile /src/platforms/android/app/build/outputs/apk/debug/app-debug.apk priv/static

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