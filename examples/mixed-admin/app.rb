require './boot'

E.new do
  
  mount Rear.controllers, '/admin'
  mount Admin
  puts urlmap
  run server: :Thin, port: 2424
end
