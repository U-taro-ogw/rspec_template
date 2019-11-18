FROM ruby:2.6.3

# RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs


RUN mkdir /usr/src/rspec_template
WORKDIR /usr/src/rspec_template
COPY Gemfile* /usr/src/rspec_template/
RUN bundle install
COPY . /usr/src/rspec_template/
