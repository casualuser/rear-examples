class Photo
  include DataMapper::Resource
  include Rear
  
  under :HasManyThrough

  property :name,  String
  property :id,    Serial
  property :gamma, String

  has n, :taggings
  has n, :tags, through: :taggings

end
