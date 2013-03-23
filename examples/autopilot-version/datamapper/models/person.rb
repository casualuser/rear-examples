class Person
  include DataMapper::Resource
  include Rear
  under :HasOne

  property :id,   Serial
  property :name, String
  
  has 1, :profile
end
