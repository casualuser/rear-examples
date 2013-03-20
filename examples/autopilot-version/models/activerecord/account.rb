class Account < ActiveRecord::Base
  include Rear
  under :HasOneThrough

  belongs_to :supplier
  has_one :account_history
end

class AccountHistory < ActiveRecord::Base
  include Rear
  under :HasOneThrough
  
  belongs_to :account
end
