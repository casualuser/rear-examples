class Article < ActiveRecord::Base
  include Rear
  under :HasAndBelongsToMany
  input :content, :rte
  assoc_columns :name

  has_and_belongs_to_many :categories, join_table: :article_categories
end
