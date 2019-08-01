class AddAwardToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :award, :decimal
  end
end
