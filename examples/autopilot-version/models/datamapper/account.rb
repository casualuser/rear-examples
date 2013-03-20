class Account
  include DataMapper::Resource
  include Rear
  under :HasOneThrough

  property :id,   Serial
  property :name, String

  belongs_to :supplier, required: false
  has 1, :account_history
end
 
class AccountHistory
  include DataMapper::Resource
  include Rear
  under :HasOneThrough

  property :id,   Serial
  property :name, String

  belongs_to :account, required: false
end
