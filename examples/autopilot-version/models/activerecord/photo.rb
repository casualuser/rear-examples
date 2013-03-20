class Photo < ActiveRecord::Base
  include Rear
  under :HasManyThrough

  has_many :taggings
  has_many :tags, through: :taggings
end
