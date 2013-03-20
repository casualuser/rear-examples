class Photo
  include DataMapper::Resource
  include Rear
  label :Photos

  property :id,   Serial
  property :name, String
end
