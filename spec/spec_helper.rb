require './server'
require './models/medicaltest'
require 'rack/test'
require 'rake'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before(:suite) do
    Rake::DefaultLoader.new.load './Rakefile'
  end
end
