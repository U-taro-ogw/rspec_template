FROM ruby:3.1.2

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /usr/src/rspec_template
WORKDIR /usr/src/rspec_template
COPY Gemfile* /usr/src/rspec_template/
RUN bundle install
COPY . /usr/src/rspec_template/
