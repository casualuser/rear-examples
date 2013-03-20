class Category
  include DataMapper::Resource
  include Rear
  under :HasAndBelongsToMany

  property :id,   Serial
  property :name, String

  has n, :articles, through: Resource

  has n, :user_children, 'Categoryship', child_key: [ :source_id ]
  has n, :user_parents,  'Categoryship', child_key: [ :target_id ]

  has n, :children, self, through: :user_children, via: :target
  has n, :parent,   self, through: :user_parents,  via: :source
end

class Categoryship
  include DataMapper::Resource

  belongs_to :source, 'Category', key: true
  belongs_to :target, 'Category', key: true
end
