require 'httparty'

class ItemClient 
  include HTTParty
    base_uri "http://localhost:8080/item"
	format :json
 
 
  def self.new_Item(item) 
    post '/items', body: item.to_json, 
         headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end 
  
  def self.update_Item(item)
     put "/items/#{item[:id]}", body: item.to_json, 
         headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end
  
  def self.getId(id)
    get "/items/#{id}" 
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
      response = ItemClient.new_Item description: description, price: price, stockQty: stockQty
      puts "status code #{response.code}"
      puts response.body 
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
      response = ItemClient.update_Item  id: id, description: description, price: price, stockQty: stockQty
      puts "status code #{response.code}"
      puts response.body 
      puts 
    when 'get'
      puts 'enter id of item to lookup'
      id = gets.chomp!
      response = ItemClient.getId(id)
      puts "status code #{response.code}"
      puts response.body 
      puts
    else 
      puts "I don't understand.  Try again."
  end 
end 

