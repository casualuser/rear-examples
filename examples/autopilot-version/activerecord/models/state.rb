class State < ActiveRecord::Base
  include Rear
  under :BelongsTo

  has_many :cities, foreign_key: :state_code, primary_key: :code
end
