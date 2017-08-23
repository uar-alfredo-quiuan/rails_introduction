class SystemMailer < ActionMailer::Base
  default from: "notifications@example.com"
  default to: "user@example.com"
  
  def contract_payed_email(contract)
    @contract = contract
    mail(subject: 'Contract balance was paid in full')
  end
  
  def contract_unpayed_email(contracts)
    @contracts = contracts
    mail(subject: 'Contracts not paid in full up to today')
  end
end
