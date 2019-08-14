class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :itemId
      t.string :description
      t.integer :customerId
      t.decimal :price
      t.decimal :award
      t.decimal :total

      t.timestamps
    end
  end
end
