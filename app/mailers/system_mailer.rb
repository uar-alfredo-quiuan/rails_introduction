class SystemMailer < ActionMailer::Base
  default from: "notifications@example.com"
  
  def contract_payed_email(contract)
    @contract = contract
    mail(to: "alfredoquiuan@gmail.com", subject: 'Contract balance was paid in full')
  end
end
