class Photos < E
  include Rear
  # pass model name as symbol or string if it is not yet defined
  model :Photo

  input :gamma, :checkbox do
    options("Red", "Green", "Blue") { item.gamma.to_s.split(',') }
  end
  
  on_save do
    params[:gamma] = params[:gamma].join(',') if params[:gamma].is_a?(Array)
  end
  
  quick_filter :gamma, cmp: :like
end

class Tags < E
  include Rear
  model 'Tag'
end
