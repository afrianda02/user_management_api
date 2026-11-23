# syntax=docker/dockerfile:1
FROM ruby:3.2.2-slim AS base

ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle

WORKDIR /app

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential default-libmysqlclient-dev pkg-config libssl-dev \
      libyaml-dev zlib1g-dev git curl && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock* ./
RUN bundle install && rm -rf ~/.bundle

FROM base AS development
ENV RAILS_ENV=development BUNDLE_WITHOUT=""
COPY . .
EXPOSE 3000
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails db:prepare && bundle exec rails server -b 0.0.0.0"]

FROM base AS production
COPY . .
RUN bundle exec rails assets:precompile 2>/dev/null || true
EXPOSE 3000
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails db:migrate && bundle exec puma -C config/puma.rb"]