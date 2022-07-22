require 'sinatra/base'
require 'rack/handler/puma'
require 'securerandom'
require './workers/csv_worker'
require './models/medicaltest'

class Server < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests/:token' do
    data = MedicalTest.find_all(params['token'])

    return 404 unless data

    data.to_json
  end

  get '/tests/?' do
    MedicalTest.all.to_json
  end

  post '/import/?' do
    data = request.body.read

    return 400 unless data.length > 0

    filename = SecureRandom.hex(12)
    path = File.join('.', 'imports', "#{filename}.csv")
    File.open(path, 'wb') { |f| f.write data }
    CSVJob.perform_async(path)
  end

  run! if app_file == $0
end

