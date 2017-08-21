class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|
      t.string :name
      t.float :price
      t.references :contract, index: true

      t.timestamps
    end
  end
end
