require 'bundler/setup'
Bundler.require

class FileManager < E
  include Rear
  fm_root File.expand_path('../../../assets/files', __FILE__)
end

Rear.run server: :Thin, port: 2424
