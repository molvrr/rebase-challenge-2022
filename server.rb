require 'sinatra/base'
require 'rack/handler/puma'
require './workers/csv_worker'
require './models/medicaltest'

class Server < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests/:token' do
    data = MedicalTest.find_all(params['token'])
    return data.to_json if data

    404
  end

  get '/tests/?' do
    MedicalTest.all.to_json
  end

  post '/import/?' do
    return 400 if request.body.class != Tempfile

    data = request.body.read
    if data.length > 0
      filename =  File.basename(request.body.to_path)
      path = File.join('.', 'imports', "#{filename}.csv")
      File.open(path, 'wb') { |f| f.write data }
      CSVJob.perform_async(path)
    end
  end

  run! if app_file == $0
end

