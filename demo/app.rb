require 'logger'
require 'bundler/setup'
Bundler.require
require './models'

ActiveRecord::Base.establish_connection 'mysql://dev@localhost/dev__rear_demo'
ActiveRecord::Base.logger = Logger.new(STDOUT)

Rear.run server: :Thin, port: 2424
