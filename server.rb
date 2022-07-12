require 'sinatra'
require 'rack/handler/puma'
require './medicaltest'

get '/tests' do
  MedicalTest.all.to_json
end

post '/import' do
  begin
    MedicalTest.from_csv(request.params["data"][:tempfile])
    201
  rescue
    500
  end
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
