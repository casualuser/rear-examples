require 'logger'
require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection 'mysql://dev@localhost/dev__rear_examples'
ActiveRecord::Base.logger = Logger.new(STDOUT)

class State < ActiveRecord::Base
  include Rear

  has_many :cities, foreign_key: :state_code, primary_key: :code
end

class City < ActiveRecord::Base
  include Rear
  
  belongs_to :state, foreign_key: :state_code, primary_key: :code

  # filter cities by state
  assoc_filter :state

  input :State, editor: false do
    pane { item.state && item.state.name }
  end
end

class Category < ActiveRecord::Base
  include Rear

  has_and_belongs_to_many :articles, join_table: :article_categories
end

class Article < ActiveRecord::Base
  include Rear

  has_and_belongs_to_many :categories, join_table: :article_categories

  assoc_filter :categories

  input :content, pane: false
  input :Categories, editor: false do
    pane { item.categories.map {|c| c.name}*', ' }
  end
end

Rear.run port: 2424, server: :Thin
