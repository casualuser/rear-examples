require './boot'

EspressoApp.new do
  use Rack::ShowExceptions
  mount Rear.controllers do
    rear_templates 'view/rear'
  end

  run server: :Thin, port: 2424
end
