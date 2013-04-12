require './boot'

E.new do
  use Rack::ShowExceptions

  mount Rear.controllers

  run server: :Thin, port: 2424
end
