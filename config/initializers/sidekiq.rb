require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == ['rarobank', 's#7T$8Af3*!@c2G9']
end