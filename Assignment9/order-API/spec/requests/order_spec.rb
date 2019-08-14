require 'rails_helper'

#Basic rspec classes
RSpec.describe "Orders Service", type: :request do
  describe "GET /orders" do
    before(:each) do
      orderA = Order.create(id: 3, itemId: 1, description: "Pencil", customerId: 1001, price: 10, award: 0, total: 50);
      orderB = Order.create(id: 4, itemId: 2, description: "Cake", customerId: 1001, price: 20, award: 0, total: 100)
    end 
    it "get orders by id" do 
      get '/orders/3',  headers: {"CONTENT_TYPE" => "application/json" ,
                                  "ACCEPT" => "application/json" }   
      expect(response).to have_http_status(200)
      json_order = JSON.parse(response.body)
      expect(json_order['id']).to eq 3
    end 
      
    it "get orders by id not found" do 
       get '/orders/900',  headers: {"CONTENT_TYPE" => "application/json" ,
                                  "ACCEPT" => "application/json" }   
       expect(response).to have_http_status(404)
    end 
    
    it "get orders by customerId"  do
      get '/orders?customerId=1001',  headers: {"CONTENT_TYPE" => "application/json" ,
                                  "ACCEPT" => "application/json" } 
      expect(response).to have_http_status(200)
      json_orders = JSON.parse(response.body)
      expect(json_orders.size).to eq 2
    end 
    
   it "get orders by customerId wrong id"  do
      get '/orders?customerId=1002',  headers: {"CONTENT_TYPE" => "application/json" ,
                                  "ACCEPT" => "application/json" } 
      expect(response).to have_http_status(200)
      json_orders = JSON.parse(response.body)
      expect(json_orders.size).to eq 0
    end 
    
    it "get orders by customer email" do
      expect(OrderHelper).to receive(:getEmail).with('123@example.com') do
         [{"id" => 1001, 'award'=> 0 }]
      end 
      get '/orders?email=123@example.com',  headers: {"CONTENT_TYPE" => "application/json" ,
                                  "ACCEPT" => "application/json" } 
      expect(response).to have_http_status(200)
      json_orders = JSON.parse(response.body)
      expect(json_orders.size).to eq 0
    end 
  end 
end