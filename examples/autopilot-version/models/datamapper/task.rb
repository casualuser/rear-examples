class Task
  include DataMapper::Resource
  include Rear
  under :HasMany

  property :id,        Serial
  property :name,      String
  property :priority,  String

  belongs_to :worker, required: false
end
