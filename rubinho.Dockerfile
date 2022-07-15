FROM ruby:3.0.0
WORKDIR /app
COPY . .
RUN bundle install
CMD ["ruby", "server.rb"]
