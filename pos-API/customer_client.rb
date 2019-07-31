require 'httparty'

base_url = "http://localhost:8080/customers"
class Foo
  include HTTParty
end

loop do   
  puts "What do you want to do: register, email, id or quit"   
  answer = gets.chomp   
  if answer == "register"
      puts "enter lastName, firstName and email for new customer"
      userInfo = gets
      userInfoArray =  userInfo.split(' ')
      lastNameInput = userInfoArray[0]
      firstNameInput = userInfoArray[1]
      emailInput = userInfoArray[2]
      response =Foo.post(base_url, body: {customer:{email: emailInput, firstName:  firstNameInput, lastName: lastNameInput} })
      puts JSON.parse(response.body)
      
  elsif answer == "email" 
      puts "enter email"
      userEmail = gets.chomp  
      response = Foo.get(base_url+"?email="+userEmail)
      puts JSON.parse(response.body)
  elsif answer == "id" 
      puts "enter id"
      userID = gets.chomp  
      response = Foo.get(base_url+"?id="+userID)
      puts JSON.parse(response.body)
  elsif answer == "quit" 
      break   
  end   
end  