class State
  include DataMapper::Resource
  include Rear
  under :BelongsTo
  
  property :id, Serial
  property :name, String, index: true
  property :code, String, unique: true, length: 2

  has n, :cities, child_key: :state_code, parent_key: :code
end
