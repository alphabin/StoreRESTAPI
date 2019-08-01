class CustomersController < ApplicationController
  before_action :get_customer, only: [:show]

  def index
    if params['id'].present?
      @customer= Customer.where(:id => params['id'])
      render(json: @customer , status: 200 )
    elsif params['email'].present?
      @customer= Customer.where(:email => params['email'])
      render(json: @customer , status: 200 )
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
     orderId = incomingOrder["id"] 
     
  end
  
 
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.json { render json: @customer, status: 200 }
      else
        format.json { render json:  @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @customer.update(city_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, customer: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
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
      params.require(:order).permit(:id).permit(:itemId).permit(:description).permit(:customerId)
      .permit(:price).permit(:award).permit(:total)
    end
end
