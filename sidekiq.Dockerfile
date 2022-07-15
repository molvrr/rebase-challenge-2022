FROM ruby:3.0.0
WORKDIR /app
COPY . .
RUN bundle install
CMD ["bundle", "exec", "sidekiq", "-r", "./workers/csv_worker.rb"]
