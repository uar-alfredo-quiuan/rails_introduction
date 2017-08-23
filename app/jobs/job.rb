module Job
  require 'ostruct'
  include ContractsHelper

  @queue = :job_queue

  def self.perform()
    @contracts = unpayed_contract()
    SystemMailer.contract_unpayed_email(@contracts).deliver
  end
  
  private
  
  def self.unpayed_contract
    Contract.all.select{|contract| contract.contract_balance > 0}.map {|contract| create_result(contract)}.sort_by(&:balance).reverse
  end
  
  def self.create_result(contract)
    OpenStruct.new(:name => contract.name, :total => contract.total_payment, :balance => contract.contract_balance)
  end

end