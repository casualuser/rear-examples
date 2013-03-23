class Person < ActiveRecord::Base
  include Rear
  under :HasOne
  
  has_one :profile
end
