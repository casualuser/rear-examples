class City < ActiveRecord::Base
  include Rear
  under :BelongsTo
  
  belongs_to :state, foreign_key: :state_code, primary_key: :code
end
