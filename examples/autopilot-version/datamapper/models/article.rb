class Article
  include DataMapper::Resource
  include Rear
  under :HasAndBelongsToMany
  input :content, :rte
  assoc_columns :name

  property :id,      Serial
  property :name,    String
  property :content, Text

  has n, :categories, through: Resource
end
