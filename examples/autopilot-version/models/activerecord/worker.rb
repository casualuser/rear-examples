class Worker < ActiveRecord::Base
  include Rear
  under  :HasMany
  filter :active

  has_many :tasks
end
