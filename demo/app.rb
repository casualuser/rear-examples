require 'logger'
require 'bundler/setup'
Bundler.require
require './models'

ActiveRecord::Base.establish_connection 'mysql://dev@localhost/dev__rear_demo'
ActiveRecord::Base.logger = Logger.new(STDOUT)

class FileManager < E
  include Rear
  fm_root File.expand_path('../public', __FILE__)
  fm_editor :ace
end

Rear.run server: :Thin, port: 2424
