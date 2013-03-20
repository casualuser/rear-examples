class Photo
  include DataMapper::Resource
  include Rear

  property :name,  String
  property :id,    Serial
  property :gamma, String
end

class Tag
  include DataMapper::Resource
  include Rear

  readonly!

  property :name, String
  property :id, Serial

end
