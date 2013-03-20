class Category < ActiveRecord::Base
  include Rear
  under :HasAndBelongsToMany

  has_and_belongs_to_many :articles, join_table: :article_categories
end
