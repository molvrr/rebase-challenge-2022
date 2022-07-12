require 'sinatra/base'
require 'rack/handler/puma'
require './medicaltest'
require 'sidekiq'
require './workers/csv_worker'

Sidekiq.configure_server do |config|
  config.redis = {
    host: 'redis',
    port: ENV['REDIS_PORT'] || '6379'
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    host: 'redis',
    port: ENV['REDIS_PORT'] || '6379'
  }
end

class Server < Sinatra::Base
  set :bind, '0.0.0.0'
  set :server, 'puma'
  set :port, 3000
  enable :logging

  get '/tests' do
    MedicalTest.all.to_json
  end

  post '/import' do
    begin
      CSVJob.perform_async("#{Time.now.to_i}", request.params['data'][:tempfile].path)
      201
    rescue
      500
    end
  end

  run! if app_file == $0
end

