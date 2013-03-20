class Task < ActiveRecord::Base
  include Rear
  under :HasMany

  belongs_to :worker
end
