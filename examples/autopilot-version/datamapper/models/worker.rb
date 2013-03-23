class Worker
  include DataMapper::Resource
  include Rear
  under  :HasMany
  filter :active

  property :id,     Serial
  property :name,   String
  property :active, Boolean
  has n, :tasks
end
