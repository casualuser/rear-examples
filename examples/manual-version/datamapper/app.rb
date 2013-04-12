require './boot'

E.new do
  use Rack::ShowExceptions

  mount Rear.controllers, '/admin'

  run server: :Thin, port: 2424
end
