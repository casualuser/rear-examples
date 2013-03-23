class Profile
  include DataMapper::Resource
  include Rear
  under :HasOne

  property :id,   Serial
  property :name, String

  belongs_to :person, required: false
end
