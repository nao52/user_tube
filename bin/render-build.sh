#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# アプリリリース後に戻す
bundle exec rails db:migrate

# 本番環境にテストデータを作成
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset
# bundle exec rails db:seed