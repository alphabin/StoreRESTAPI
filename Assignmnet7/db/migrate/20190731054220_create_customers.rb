class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :lastName
      t.string :firstName
      t.decimal :lastOrder
      t.decimal :lastOrder2
      t.decimal :lastOrder3

      t.timestamps
    end
  end
end
