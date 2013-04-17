class Article
  include DataMapper::Resource
  include Rear
  input :content, :ckeditor, public_path: File.expand_path('../../../assets/files', __FILE__)
  assoc_columns :name

  property :id,      Serial
  property :name,    String
  property :content, Text

  has n, :categories, through: Resource
end

class Category
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  has n, :articles, through: Resource
end
