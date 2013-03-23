class Supplier
  include DataMapper::Resource
  include Rear
  under :HasOneThrough

  property :id,   Serial
  property :name, String

  has 1, :account
  has 1, :account_history, through: :account
end
