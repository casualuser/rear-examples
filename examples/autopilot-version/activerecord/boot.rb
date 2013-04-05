require 'logger'
require 'bundler/setup'
Bundler.require

pattern = File.expand_path('../models/*.rb', __FILE__)
Dir[pattern].each {|f| require f}

ActiveRecord::Base.establish_connection 'mysql://dev@localhost/dev__rear_examples'
ActiveRecord::Base.logger = Logger.new(STDOUT)
