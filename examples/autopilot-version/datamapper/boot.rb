require 'bundler/setup'
Bundler.require

pattern = File.expand_path('../models/*.rb', __FILE__)
Dir[pattern].each {|f| require f}

DataMapper.finalize
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup :default, 'mysql://dev@localhost/dev__rear_examples'
DataMapper::Model.raise_on_save_failure = true
