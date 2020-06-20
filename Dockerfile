ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-alpine

ARG BUNDLER_VERSION

RUN apk add \
  build-base \
  bash \
  sqlite-dev \
  tzdata

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

# Create a directory for the app code
WORKDIR /hivebrite-backend-test
