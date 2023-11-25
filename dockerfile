# ベースとなるDockerイメージを選択(ruby 3.1.4を使用する)
ARG RUBY_VERSION=ruby:3.1.4
ARG NODE_VERSION=20
ARG APP_NAME=user_tube

FROM $RUBY_VERSION
ARG RUBY_VERSION
ARG NODE_VERSION
ARG APP_NAME
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# 「Node.js」および「yarnパッケージ」のダウンロードを行っている。
# -----
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg && apt-key add /tmp/pubkey.gpg \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn
# -----

#作成予定のアプリケーション名を使用する
RUN mkdir /${APP_NAME}
WORKDIR /${APP_NAME} 

# RubyGemsのバージョンがRuby 3.1.4に対応するように「system 3.3.3」を指定している。
RUN gem update --system 3.3.3

RUN gem install bundler
COPY Gemfile /${APP_NAME}/Gemfile
COPY Gemfile.lock /${APP_NAME}/Gemfile.lock
COPY yarn.lock /${APP_NAME}/yarn.lock
RUN bundle install
RUN yarn install
COPY . /${APP_NAME}
