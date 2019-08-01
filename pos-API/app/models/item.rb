class Item < ApplicationRecord

  validates_presence_of :description, :price, :stockQty 
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :stockQty, only_integer:true, greater_than_or_equal_to: 0 
 
end