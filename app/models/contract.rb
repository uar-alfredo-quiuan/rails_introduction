class Contract < ActiveRecord::Base
  has_many :merchandises
  has_many :payments
  accepts_nested_attributes_for :merchandises, :payments
end
