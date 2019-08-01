require 'rails_helper'

RSpec.describe "ItemsController", type: :request do

    before(:each) do
      @headers =  { "CONTENT_TYPE" => "application/json" ,
                    "ACCEPT" => "application/json"}    # Rails 4
    end
  
    it 'create item' do 
      item = {'description' => 'ruler',
              'price' => 3.99 ,
              'stockQty' => 9 }
  
      post '/items', :params => item.to_json, :headers => @headers
      expect(response).to have_http_status(201)      
      item_response = JSON.parse(response.body)
      expect(item_response).to include item
      # verify database update
      id = item_response['id']
      dbitem = Item.find(id)
      expect(dbitem).to be_truthy
    end
    
    it 'update item' do
      # create database record    
      dbitem = Item.create(
              'description' => 'ruler',
              'price' => 3.99 ,
              'stockQty' => 9 )
      item = { 'id' => dbitem.id, 'price' => 1.99, 'stockQty' => 75 }
      put "/items/#{dbitem.id}", :params => item.to_json, :headers => @headers
      expect(response).to have_http_status(204)      
      # verify database update
      dbitem.reload 
      expect(dbitem.price).to eq 1.99
      expect(dbitem.stockQty).to eq 75
    end
    
    it 'order item that is in stock' do
      item = Item.create(
              'description' => 'pearl necklace',
              'price' => 3.99 ,
              'stockQty' => 9 )
              
      order = {id: 1, itemId: item.id  }
      put "/items/order", :params => order.to_json,  :headers => @headers
      expect(response).to have_http_status(204)      
      #verify db update
      item.reload
      expect(item.stockQty).to eq 8 
    end
    
    it 'purchase item not in stock should fail' do
      order = {id: 1, itemId: 99 }
      put "/items/order", :params => order.to_json,  :headers => @headers
      expect(response).to have_http_status(404)      
    end
    
    it 'retrieve item by id' do 
       Item.create(
              'description' => 'ruler',
              'price' => 3.99 ,
              'stockQty' => 3 );
      get "/items/1",  :headers => @headers
      expect(response).to have_http_status(200)
      items_response = JSON.parse(response.body)
      expect(items_response['id']).to eq 1
    end 
    
    it 'retrieve item by id that does not exist should fail' do 
      get "/items/99",   :headers => @headers
      expect(response).to have_http_status(404)
      
    end 

end