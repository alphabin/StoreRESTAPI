class ItemsController < ApplicationController
  def new_Item	
    @item = Item.new
    update(@item) 
    if @item.save
      render "item.json.jbuilder", status: 201
    else
      render(json: {messages: @item.errors.messages}, status: 400)
    end
  end
  
  def retrieve_Item
    @item = Item.find_by(id: params[:id])
    if @item.nil?
       head 404  
    else 
      render "item.json.jbuilder"
    end 
  end

  def update_Item 
    @item = Item.find_by(id: params[:id])
    if @item.nil?
      render 404 
    else 
      update(@item)
      if @item.save()
         head 204
      else 
        render(json: {messages: @item.errors.messages}, status: 400)    
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
	
  def update(item)
    item.id = params[:id] if params[:id].present?
    item.description = params[:description] if params[:description].present?
    item.price = params[:price].to_f if params[:price].present?
    item.stockQty = params[:stockQty].to_i if params[:stockQty].present?
  end 

end