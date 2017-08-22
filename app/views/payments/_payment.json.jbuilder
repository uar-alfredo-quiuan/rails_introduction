json.extract! payment, :id, :date, :description, :amount, :contract_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
