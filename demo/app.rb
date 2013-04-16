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

E.new do
  mount Rear.controllers do
    # when using `rear_templates`, Rear will search for templates
    # in given path and fallback to default ones if none found.
    # so creating views/rear/shared-templates/home.slim file
    # to have a custom template for home page
    rear_templates 'views/rear'
  end
  run server: :Thin, port: 2424
end
