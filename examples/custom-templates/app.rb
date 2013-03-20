require './boot'

EspressoApp.new do
  use Rack::ShowExceptions
  mount Rear.controllers do
    view_path 'view/rear'
  end

  run server: :Thin, port: 2424
end