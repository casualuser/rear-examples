require 'bundler/setup'
Bundler.require

class State
  include DataMapper::Resource
  include Rear
  
  property :id, Serial
  property :name, String, index: true
  property :code, String, unique: true, length: 2

  has n, :cities, child_key: :state_code, parent_key: :code
end

class City
  include DataMapper::Resource
  include Rear
  
  property :id, Serial
  property :name, String, index: true

  belongs_to :state, child_key: :state_code, parent_key: :code, required: false

  # filter cities by state
  assoc_filter :state

  input :State, editor: false do
    pane { item.state && item.state.name }
  end
end

class Category
  include DataMapper::Resource
  include Rear

  property :id,   Serial
  property :name, String

  has n, :articles, through: Resource

  has n, :user_children, 'Categoryship', child_key: [ :source_id ]
  has n, :user_parents,  'Categoryship', child_key: [ :target_id ]

  has n, :children, self, through: :user_children, via: :target
  has n, :parent,   self, through: :user_parents,  via: :source

  assoc_filter :parent

  input :Parents, editor: false do
    pane { item.parent.map {|p| p.name }*', ' }
  end
end

class Categoryship
  include DataMapper::Resource

  belongs_to :source, 'Category', key: true
  belongs_to :target, 'Category', key: true
end

class Article
  include DataMapper::Resource
  include Rear

  property :id,   Serial
  property :name, String

  has n, :categories, through: Resource

  assoc_filter :categories

  input :content, pane: false
  input :Categories, editor: false do
    pane { item.categories.map {|c| c.name}*', ' }
  end
end

DataMapper.finalize
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup :default, 'mysql://dev@localhost/dev__rear_examples'
DataMapper::Model.raise_on_save_failure = true

Rear.run port: 2424, server: :Thin
