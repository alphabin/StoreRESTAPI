require 'rails_helper'

RSpec.describe "Customer Status", type: :request do
  
  before(:each) do 
    Customer.create(firstName:"chatura",lastName:"ahangama",email:"chaturadroid@gmail.com")
  end 
  
  describe "GET /customer" do
    it 'get the customer by id' do
      headers = { "ACCEPT" => "application/json"} 
      get '/customers?id=1', headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 1
      customer = json_response[0]
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
    end 
  end
  
  describe "GET /customer" do
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
      orderSend = {order:{id: '420', itemId: '23', description: 'Balls', customerId: '1',price:10.30, award:0.0, total:10.30}}
      post '/customers/order',  params: orderSend, headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 1
      customer = json_response[0]
      expect(customer['firstName']).to eq 'chatura'
      expect(customer['lastName']).to eq 'ahangama'
      expect(customer['email']).to eq 'chaturadroid@gmail.com'
    end 
  end
  
end
  
