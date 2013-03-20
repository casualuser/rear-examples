require 'bundler/setup'
Bundler.require

# controllers can be required before or after models,
# just make sure to pass model name as String or Symbol if models required after controllers
require '../controllers'
require './models'

DataMapper.finalize
DataMapper.setup :default, 'mysql://dev@localhost/dev__rear_examples'
DataMapper::Model.raise_on_save_failure = true
