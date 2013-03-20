class Tag
  include DataMapper::Resource
  include Rear
  under :HasManyThrough

  property :name, String
  property :id, Serial

  has n, :taggings
  has n, :photos, through: :taggings
end

class Tagging
  include DataMapper::Resource

  belongs_to :tag,   key: true
  belongs_to :photo, key: true
end
