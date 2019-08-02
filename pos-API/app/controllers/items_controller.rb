class ItemsController < ApplicationController
  def create	
    @item = Item.new(new_params)
    respond_to do |format|
      if @item.save
        format.json { render json: @item, status: 201 }
      else
        format.json { render json:  @item.errors, status: 400 }
      end
    end
  end
  
  def show
      @item= Item.find(params[:id])
      render(json: @item , status: 200 )
  end
 
def update
  @item= Item.find(item_params[:id])
   respond_to do |format|
        if @item.update(item_params)
               format.json { render json: @item, status: 201 }
        else
        format.json { render json:  @item.errors, status: 400 }
        end
    
   end
end

  def order_Item
    @item = Item.find_by(:id => params[:itemId])
    if @item.nil?
       head 404
       return
    end
    if @item.stockQty > 0
      @item.stockQty = @item.stockQty - 1
      @item.save
      head 204
    else
      render(json: {messages: [ {:id => ['Not Found'] }  ] }, status: 400 )
    end 
  end 
	
private
     def item_params
         params.require(:item).permit(:id, :description, :price, :stockQty)
     end

    def new_params
      params.require(:itemNew).permit(:description, :price, :stockQty)
    end
end