require 'sinatra/base'
require 'rack/handler/puma'
require 'sidekiq'
require './workers/csv_worker'
require './medicaltest'

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

  get '/tests/:token' do
    data = MedicalTest.find_all(params['token'])
    return data.to_json if data

    404
  end

  get '/tests/?' do
    MedicalTest.all.to_json
  end

  post '/import/?' do
    begin
      path = params['data'][:tempfile].path
      csv_path = "imports/#{File.basename(path)}"
      FileUtils.cp(path, csv_path)
      CSVJob.perform_async(csv_path)
      201
    rescue
      500
    end
  end

  run! if app_file == $0
end

