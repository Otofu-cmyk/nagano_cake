class Public::CartItemsController < ApplicationController
  def index
    @cart_items=CartItem.all

    def total(count)
      @cart_items.each do |cart_item|
        add=cart_item.item.price*1.1*cart_item.amount
        count+=add
      end
      return count
    end

    @total=total(0)
  end

  def update
    cart_item=CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items=CartItem.all
    cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to cart_items_path
  end

  def destroy
    cart_item=CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    cart_item=CartItem.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount , :item_id).merge(customer_id: current_customer.id)
  end
end