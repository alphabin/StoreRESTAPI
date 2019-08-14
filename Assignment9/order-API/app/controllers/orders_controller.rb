class OrderHelper
    include HTTParty
    def self.getEmail(email)
      get("http://localhost:8081/customers?email=#{email}" ,
        headers:  { 'ACCEPT' => 'application/json' }).parsed_response
    end
    
    def self.getId(id)
       get("http://localhost:8082/items/#{id}" , 
        headers:  { 'ACCEPT' => 'application/json' }).parsed_response
    end
    
    def self.customerOrder(order)
      post("http://localhost:8081/customers/order" , body: {order:{id: order[:id], itemId: order[:itemId], description: order[:description], customerId: order[:customerId],price: order[:price], award: order[:award], total: order[:total]}})
    end
    
    def self.itemUpdate(order,qty)
      post("http://localhost:8082/items", body:{item: {id: order[:itemId], description: order[:description], price:  order[:price], stockQty: qty}})
    end
end


class OrdersController < ApplicationController

  # GET /orders
  # search by customerId or email
  def index 
    email = params['email']
    customerId = params['customerId']
    if !email.nil?
      customer = OrderHelper.getEmail(params[:email])

      if customer == nil
        render json: { error: "Customer email not found. #{ email }" }, status: 400
        return
      end 
      customerId = customer[0]["id"].to_i
    end
    orders = Order.where(customerId: customerId)
    if(orders == nil)
      render json: { error: "Customer email not found. #{ email }" }, status: 400
    else
      render json: orders, status: 200  
    end
  end 
  
  
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new 
    #Do Api call to order
    customer = OrderHelper.getEmail(params[:email])
    #Do Api call to item
    item = OrderHelper.getId(params[:itemId])
    
    if item["stockQty"] <= 0
      render json: { error: "Item is out of stock." } , status: 400
      return
    end 
      
    @order.itemId = params[:itemId]
    @order.description = item["description"]
    @order.customerId = customer[0]["id"].to_i
    @order.price = item["price"].to_f
    @order.award = customer[0]["award"]
    if(@order.award == nil)
      @order.award =0.0
    end
    @order.total = @order.price - @order.award
  
    if @order.save
      #Do Api call to order save
      code = OrderHelper.customerOrder(@order)
       #Do Api call to item update
      code = OrderHelper.itemUpdate( @order,item["stockQty"]-1)
      render json: @order, status: 201  
    else
      render json: @order.errors, status: 400  
    end
  end
  
  
  # GET /orders/:id
  def show
    order = Order.find_by(id: params[:id])
    if order.nil?
      render json: { error: "Not found. #{ params[:id]}" }, status: 404
    else 
      render json: order, status: 200
    end 
  end 
  
end

