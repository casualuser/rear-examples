require 'bundler/setup'
Bundler.require

require '../controllers'
require './models'

ActiveRecord::Base.establish_connection 'mysql://dev@localhost/dev__rear_examples'
