# ./Dockerfile

# Extend from the official Elixir image
FROM elixir:latest

MAINTAINER Douglas Moura <douuuglas@gmail.com>

ENV MIX_ENV=prod \
  SSH_PASSWD="root:Docker!" \
  HEX_HTTP_TIMEOUT=1200

RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd \
    && apt-get install -y postgresql-client

COPY sshd_config /etc/ssh/

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

RUN mix do local.rebar --force

RUN mix deps.get

# Compile the project
RUN mix do compile

EXPOSE 2222
EXPOSE 4000

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]