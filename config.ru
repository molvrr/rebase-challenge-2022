require 'sidekiq'
require 'sidekiq/web'
require 'securerandom'

use Rack::Session::Cookie, secret: SecureRandom.hex(32), same_site: true, max_age: 86400

run Sidekiq::Web
