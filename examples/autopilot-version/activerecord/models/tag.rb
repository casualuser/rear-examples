class Tag < ActiveRecord::Base
  include Rear
  under :HasManyThrough

  has_many :taggings
  has_many :photos, through: :taggings
end

class Tagging < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :photo
end
