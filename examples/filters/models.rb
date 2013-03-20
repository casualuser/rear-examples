class Photo
  include DataMapper::Resource
  include Rear
  under  :Photos
  filter :name
  input :gamma, :checkbox, disabled: true do
    options "Red", "Green", "Blue"
  end

  # quick_filter inherits options defined by input
  quick_filter :gamma, cmp: :like

  property :name,  String
  property :id,    Serial
  property :gamma, String

  has n, :taggings
  has n, :tags, through: :taggings
end

class Tag
  include DataMapper::Resource
  include Rear
  under :Photos

  # filter by name
  filter :name

  property :id,   Serial
  property :name, String

  has n, :taggings
  has n, :photos, through: :taggings
end

class Tagging
  include DataMapper::Resource

  belongs_to :tag,   key: true
  belongs_to :photo, key: true
end

class Person
  include DataMapper::Resource
  include Rear
  under  :Profiles

  # filter by name's first letter
  # :like_ is for LIKE 'VALUE%'
  quick_filter :name, :A, :B, :C, cmp: :like_

  property :id,   Serial
  property :name, String
  
  has 1, :profile
end

class Profile
  include DataMapper::Resource
  include Rear
  under  :Profiles

  decorative_filter :PersonsFirstLetter, :select do
    options ('A'..'Z').to_a
  end

  filter :person_id, :select do
    if letter = filter?(:PersonsFirstLetter)
      Person.all(:name.like => letter + '%').inject({}) do |items,item|
        items.merge item.id => item.name
      end
    else
      {"" => "Select Person's first letter please"}
    end
  end

  property :id,   Serial
  property :name, String

  belongs_to :person, required: false
end

class Task
  include DataMapper::Resource
  include Rear
  under :Workers

  input :priority, :radio do
    options "High", "Medium", "Low"
  end
  filter :priority

  property :id,        Serial
  property :name,      String
  property :priority,  String

  belongs_to :worker, required: false
end

class Worker
  include DataMapper::Resource
  include Rear
  under  :Workers
  filter :active

  property :id,     Serial
  property :name,   String
  property :active, Boolean
  has n, :tasks
end
