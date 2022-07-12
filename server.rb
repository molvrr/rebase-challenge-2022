require 'sinatra'
require 'rack/handler/puma'
require './medicaltest'

get '/tests' do
  MedicalTest.all.to_json
end


Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
