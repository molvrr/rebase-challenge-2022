require 'sinatra/base'
require 'rack/handler/puma'
require './medicaltest'

class Server < Sinatra::Base
  set :bind, '0.0.0.0'
  set :server, 'puma'
  set :port, 3000

  get '/tests' do
    MedicalTest.all.to_json
  end

  post '/import' do
    begin
      MedicalTest.from_csv(request.params['data'][:tempfile])
      201
    rescue
      500
    end
  end

  run! if app_file == $0
end

