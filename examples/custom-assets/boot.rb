require 'bundler/setup'
Bundler.require

require './models'

DataMapper.finalize
DataMapper.setup :default, 'mysql://dev@localhost/dev__rear_examples'
DataMapper::Model.raise_on_save_failure = true
