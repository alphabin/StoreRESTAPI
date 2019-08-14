require 'httparty'


#Helper classes
class CustomerHelper 
  include HTTParty
  
  base_uri "http://localhost:8081"
	format :json
  
  def self.registerCustomer(userInfo)
      userInfoArray =  userInfo.split(' ')
      lastNameInput = userInfoArray[0]
      firstNameInput = userInfoArray[1]
      emailInput = userInfoArray[2]
      response =post('/customers', body: {customer:{email: emailInput, firstName:  firstNameInput, lastName: lastNameInput} })
  end 
  
  def self.getEmailCustomer(email)
    get "/customers?email=#{email}"
  end
  
  def self.getIdCustomer(id)
    get "/customers?id=#{id}"
  end
end 

class ItemHelper 
  include HTTParty
  
  base_uri "http://localhost:8082"
	format :json
 
 
  def self.updateItem(item)
     put "/items/#{item[:id]}"
  end
  
  def self.getIdItem(id)
    get "/items/#{id}"
  end
  
  def self.createItem(description,price,stockQty) 
    post '/items', body: {itemNew: {description: description, price: price, stockQty: stockQty}}
  end 
end 

class OrderHelper
  include HTTParty
  
  base_uri "http://localhost:8080"
	format :json
 
  def self.getIdOrder(id)
    get "/orders/#{id}" 
  end
  
  def self.getEmailOrder(email)
    get "/orders?email=#{email}"
  end
 
  def self.createOrder(order) 
    post '/orders', body: order
         
  end 
end 


while true 
  puts "What do you want to do:\r\n(A) Register customer\r\n(B) Item create \r\n(C) Purchase \r\n(D) Customer lookup\r\n(E) Item lookup \r\n(F) Order lookup\r\n(G) By email order\r\nor quit?"
  input = gets.chomp! 
  puts  
  case input
    when 'quit'
      break
    when 'A'  
      puts 'Please enter lastName firstName email. Separate by space.'
      inputCustomer = gets.chomp
      response = CustomerHelper.registerCustomer inputCustomer
      puts "status code #{response.code}"
      puts response.body 
      puts
      
    when 'B' 
      puts '*Enter description'
      description = gets.chomp!
      puts '*Enter item price'
      price = gets.chomp!
      puts '*Enter item stockQty'
      stockQty = gets.chomp!
      response = ItemHelper.createItem(description,price,stockQty)
      puts "status code #{response.code}"
      puts response.body 
      puts
    
    when 'C'   
      puts '*Enter item id'
      itemId = gets.chomp!
      puts '*Enter email'
      email = gets.chomp!
      response = OrderHelper.createOrder itemId: itemId, email: email
      puts "status code #{response.code}"
      puts response.body unless response.code==500
      puts 
      
    when 'D'  
      puts '*Enter customer id/email'
      customerID = gets.chomp!
      if customerID.include?('@') #for emails
        response = CustomerHelper.getEmailCustomer(customerID)
      else 
        response = CustomerHelper.getIdCustomer(customerID)
      end 
      puts "status code #{response.code}"
      puts response.body 
      puts
        
    when 'E'   
      puts '*Enter id of item to lookup'
      id = gets.chomp!
      response = ItemHelper.getIdItem(id)
      puts "status code #{response.code}"
      puts response.body  
      puts
    
    when 'F'  
      puts 'Enter id of order to lookup'
      id = gets.chomp!
      response = OrderHelper.getIdOrder(id)
      puts "status code #{response.code}"
      puts response.body  
      puts
      
  when 'G'  
      puts 'Enter email of order to lookup'
      emailOrder = gets.chomp!
      response = OrderHelper.getEmailOrder(emailOrder)
      puts "status code #{response.code}"
      puts response.body 
      puts

    else
      puts "Please try again or quit" 
      puts
  end 
end 