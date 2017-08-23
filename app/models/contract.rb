class Contract < ActiveRecord::Base
  has_many :merchandises
  has_many :payments
  accepts_nested_attributes_for :merchandises, :payments
  

  def contract_balance
    self.merchandises.sum(:price) - self.total_payment
  end
  
  def total_payment
    self.payments.sum(:amount)
  end

end
