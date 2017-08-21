class Contract < ActiveRecord::Base
  has_many :merchandises
  accepts_nested_attributes_for :merchandises
end
