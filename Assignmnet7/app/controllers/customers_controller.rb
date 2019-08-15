class CustomersController < ApplicationController
  before_action :get_customer, only: [:show]

  def index
    if params['id'].present?
      @customer= Customer.where(:id => params['id'])
      render(json: @customer , status: 200 )
    elsif params['email'].present?
      @customer= Customer.where(:email => params['email'])
      render(json: @customer , status: 200 )
    else
      render(json: "", status:400)
    end
  end


  def show
  end

 
  def new
    @customer = Customer.new
  end

 
  def edit
  end

  def order
     incomingOrder = order_params
     orderId = incomingOrder["id"].to_i
     customerId = incomingOrder["customerId"].to_i
     awordAmmount = incomingOrder["award"].to_f
     itemPrice = incomingOrder["price"].to_s
     
     if awordAmmount.nil?
        awordAmmount = 0
     end
 
     @customer= Customer.where(:id =>  customerId.to_s).first
     
     lastOrder =  @customer["lastOrder"].to_f 
     lastOrder2 = @customer["lastOrder2"].to_f 
     lastOrder3 = @customer["lastOrder3"].to_f 
     if(@customer != nil)
        if(awordAmmount > 0)
            
            @customer["lastOrder"] = nil
            @customer["lastOrder2"] = nil
            @customer["lastOrder3"] = nil
        elsif (awordAmmount == 0 || awordAmmount == nil)
            if( lastOrder == 0.0 )
              @customer["lastOrder"] = itemPrice
              
            elsif( lastOrder2== 0.0)
              @customer["lastOrder2"] = itemPrice
             
            elsif( lastOrder3 ==0.0)
               @customer["lastOrder3"] = itemPrice
             
            end
            
                  
             lastOrder =  @customer["lastOrder"].to_f 
             lastOrder2 = @customer["lastOrder2"].to_f 
             lastOrder3 = @customer["lastOrder3"].to_f 

            
            if(  lastOrder > 0 && lastOrder2 > 0 && lastOrder3  > 0)
                itemTotal =  lastOrder  + lastOrder2  + lastOrder3
                award = (itemTotal/3.0)*(0.10)
                @customer["award"] = award 
            end
            respond_to do |format|
              if @customer.save
                  format.json { render json: @customer, status: 200 }
              else
                  format.json { render json:  @customer.errors, status: 400 }
              end
            end
        end
     end
  end

 
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.json { render json: @customer, status: 200 }
      else
        format.json { render json:  @customer.errors, status: 400 }
      end
    end
  end


  def update
    respond_to do |format|
      if @customer.update(city_params)
       format.json { render json: @customer, status: 200 }
      else
        format.json { render json:  @customer.errors, status: 400 }
      end
    end
  end

 private
    def get_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
       params.require(:customer).permit(:email, :firstName, :lastName)
    end
    
    def order_params
      params.require(:order).permit(:id,:itemId,:description,:customerId,:price,:award,:total)
    end
end
