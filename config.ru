require 'sidekiq'
require 'sidekiq/web'

use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

run Sidekiq::Web
