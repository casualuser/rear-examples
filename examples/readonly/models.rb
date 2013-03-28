class Photo
  include DataMapper::Resource
  include Rear
  readonly_assoc :tags

  property :name,  String
  property :id,    Serial
  property :gamma, String

  has n, :taggings
  has n, :tags, through: :taggings
end

class Tag
  include DataMapper::Resource
  include Rear
  readonly!

  property :name, String
  property :id, Serial

end

class Tagging
  include DataMapper::Resource

  belongs_to :tag,   key: true
  belongs_to :photo, key: true
end
