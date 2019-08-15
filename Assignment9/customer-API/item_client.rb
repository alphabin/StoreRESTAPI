require 'httparty'

class ItemClient 
  include HTTParty
    base_uri "http://localhost:8080/items"
	format :json
 
 
  def self.new_Item(item) 
      response =post(base_uri, body: item)
      puts JSON.parse(response.body)
  end 
  
  def self.update_Item(item)
      response =put(base_uri, body: item)
      puts JSON.parse(response.body)
  end
  
  def self.getId(id)
      response = get(base_uri+"/"+id)
      puts JSON.parse(response.body)
  end
  
end 

while true 
  puts "What do you want to do: new_Item, update_Item, get or quit"
  cmd = gets.chomp!
  puts  
  case cmd
    when 'quit' 
      break
    when 'new_Item'
      puts 'enter item description'
      description = gets.chomp!
      puts 'enter item price'
      price = gets.chomp!
      puts 'enter item stockQty'
      stockQty = gets.chomp!
      response = ItemClient.new_Item itemNew: {description: description, price: price, stockQty: stockQty}
      puts 
    when 'update_Item'
      puts 'enter id of item to update'
      id = gets.chomp!
      puts 'enter  description'
      description = gets.chomp!
      puts 'enter  price'
      price = gets.chomp!
      puts 'enter  stockQty'
      stockQty = gets.chomp!
      response = ItemClient.update_Item  item: {id: id, description: description, price: price, stockQty: stockQty}
      puts 
    when 'get'
      puts 'enter id of item to lookup'
      id = gets.chomp!
      response = ItemClient.getId(id)
      puts
    else 
      puts "I don't understand.  Try again."
  end 
end 

