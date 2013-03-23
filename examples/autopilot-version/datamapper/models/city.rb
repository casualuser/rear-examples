class City
  include DataMapper::Resource
  include Rear
  under :BelongsTo
  
  property :id, Serial
  property :name, String, index: true

  belongs_to :state, child_key: :state_code, parent_key: :code, required: false
end
