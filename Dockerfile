FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  chromium \
  chromium-driver

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]