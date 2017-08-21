class Merchandise < ActiveRecord::Base
  belongs_to :contract
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
