class Photo
  include DataMapper::Resource

  property :name,  String
  property :id,    Serial
  property :gamma, String

  has n, :taggings
  has n, :tags, through: :taggings
end

class Tag
  include DataMapper::Resource

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
