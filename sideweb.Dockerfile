FROM ruby:3.0.0
WORKDIR /app
COPY . .
RUN bundle install
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3535"]
