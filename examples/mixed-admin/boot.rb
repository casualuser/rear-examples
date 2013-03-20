require 'bundler/setup'
Bundler.require

require './models'
require './controllers'

DataMapper.finalize
DataMapper.setup :default, 'mysql://dev@localhost/dev__rear_examples'
DataMapper::Model.raise_on_save_failure = true
