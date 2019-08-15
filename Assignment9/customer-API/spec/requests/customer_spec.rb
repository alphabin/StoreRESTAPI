require 'rails_helper'

RSpec.describe "Customer Status", type: :request do
  
  before(:each) do 
    Customer.create(firstName:"chatura",lastName:"ahangama",email:"chaturadroid@gmail.com")
  end 
  
  describe "GET /customers retrieve customer data" do
    it 'get the customer by id' do
      headers = { "ACCEPT" => "application/json"} 
      get '/customers?id=1', headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to be > 0
      customer = json_response[0]
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
    end 
  end
  
  describe "POST /customers register a new customer" do
    it 'new customer by id' do
      headers = { "ACCEPT" => "application/json"}
      newCustomer = {customer:{email: "charly@gmail.com", firstName:  "charles", lastName: "swab"} }
      post '/customers',params:  newCustomer, headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to be > 0
      customer = json_response
      id = customer['id']
      dbItem = Customer.find(id)
      expect(dbItem).to be_truthy
    end 
  end
  
  describe "GET /customer retrieve customer data" do
    it 'get the customer by email' do
      headers = { "ACCEPT" => "application/json"} 
      get '/customers?email=chaturadroid@gmail.com', headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 1
      customer = json_response[0]
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
    end 
  end
  
  describe "POST /customer/order" do
    it 'make an order' do
      headers = { "ACCEPT" => "application/json"} 
      orderSend = {order:{id: '420', itemId: '23', description: 'Balls', customerId: '1',price:100.00, award:0.0, total:10.30}}
      post '/customers/order',  params: orderSend, headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 10
      customer = json_response
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
       expect(customer['lastOrder']).to eq "100.0"
      expect(customer['award']).to eq nil
      
      orderSend = {order:{id: '420', itemId: '23', description: 'Balls', customerId: '1',price:200.00, award:0.0, total:10.30}}
      post '/customers/order',  params: orderSend, headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 10
      customer = json_response
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
      expect(customer['lastOrder2']).to eq "200.0"
      expect(customer['award']).to eq nil
      
      orderSend = {order:{id: '420', itemId: '23', description: 'Balls', customerId: '1',price:175.00, award:0.0, total:10.30}}
      post '/customers/order',  params: orderSend, headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 10
      customer = json_response
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
      expect(customer['lastOrder3']).to eq "175.0"
      expect(customer['award']).to eq "15.8333333333333"
      
      

    end 
  end
  
end
  
