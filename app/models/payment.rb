class Payment < ActiveRecord::Base
  belongs_to :contract
  validates :description, presence: true
  validate :payment_date_cannot_be_in_the_future
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :balance_cannot_be_negative_on_create, on: :create
  validate :balance_cannot_be_negative_on_update, on: :update
  
  def payment_date_cannot_be_in_the_future
    if !payment_date.present? or payment_date > Date.today
      errors.add(:payment_date, "can't be blank or in the future")    
    end
  end
  
  def balance_cannot_be_negative_on_create
    check_balance(contract_id, amount)  
  end

  def balance_cannot_be_negative_on_update
    payment = Payment.find(id)
    value =  amount.to_f - payment.amount
    check_balance(contract_id, value)
  end

  private
  
  def check_balance(contract_id, amount)
    contract = Contract.find(contract_id)
    balance = contract.contract_balance
    if balance < amount.to_f
      errors.add(:amount, "can't be greater than the balance: #{balance}")    
    end
  end
    
end
