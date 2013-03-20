class Photo
  include DataMapper::Resource
  include Rear
  
  input :gamma, :checkbox do
    options("Red", "Green", "Blue") { item.gamma.to_s.split(',') }
  end
  on_save do
    params[:gamma] = params[:gamma].join(',') if params[:gamma].is_a?(Array)
  end

  quick_filter :gamma, cmp: :like

  property :id,    Serial
  property :name,  String
  property :gamma, String
end
