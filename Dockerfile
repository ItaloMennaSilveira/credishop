FROM ruby:3.3.6

RUN apt-get update -qq && apt-get install -y \
  curl \
  gnupg2 \
  build-essential \
  libpq-dev \
  git \
  libvips \
  postgresql-client

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

COPY Gemfile* ./

RUN gem install bundler && bundle install

COPY . .

RUN node -v
RUN yarn -v
RUN which yarn

RUN yarn install --check-files

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bin/rails server -b 0.0.0.0"]
