class RearAce

  ASSETS = (File.expand_path('../../assets', __FILE__) + '/').freeze

  MODES = Dir[ASSETS + 'ace/mode-*.js'].map do |e|
    File.basename(e).gsub(/\Amode\-|\.js\Z/, '')
  end.freeze
  
  THEMES = Dir[ASSETS + 'ace/theme-*.js'].map do |e|
    File.basename(e).gsub(/\Atheme\-|\.js\Z/, '')
  end.reject {|t| t == 'kr'}.freeze
end

module RearSharedActions

  def get_ace_assets(*)
    env['PATH_INFO'] = env['PATH_INFO'].to_s.sub(/\-rear\Z/, '')
    send_files RearAce::ASSETS
  end
end
