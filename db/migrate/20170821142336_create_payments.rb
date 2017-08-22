class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :payment_date
      t.text :description
      t.float :amount
      t.references :contract, index: true

      t.timestamps
    end
  end
end
