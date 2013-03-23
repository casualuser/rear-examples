class Supplier < ActiveRecord::Base
  include Rear
  under :HasOneThrough
  
  has_one :account
  has_one :account_history, through: :account
end
