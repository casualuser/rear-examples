class Photo < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings
end

class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :photos, through: :taggings
end

class Tagging < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :photo
end
