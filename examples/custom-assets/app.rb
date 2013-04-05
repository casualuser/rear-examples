require './boot'

EspressoApp.new do
  use Rack::ShowExceptions
  mount Rear.controllers do
    # before first start execute
    # $ rear i:a assets/
    # to install Rear's assets into assets/ folder
    rear_assets 'assets/rear-assets'
  end

  run server: :Thin, port: 2424
end
