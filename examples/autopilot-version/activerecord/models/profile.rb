class Profile < ActiveRecord::Base
  include Rear
  under :HasOne

  belongs_to :person
end
