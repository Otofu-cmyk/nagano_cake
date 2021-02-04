class Admin::OrdersController < ApplicationController
  def index
    @order=Order.all.page(params[:page]).per(10)
    @ordered_products=OrderedProduct.all
  end

  def show
    @order=Order.find(params[:id])
    @ordered_products=OrderedProduct.where(order_id: params[:id])
  end

  def update
    if params[:status]=="ordered_status"
      order=Order.find(params[:id])
      order.update(ordered_status: params["ordered_status"])
    else
      ordered_product=OrderedProduct.find(params[:ordered_product_id])
      ordered_product.update(making_status: params["making_status"])
    end
      redirect_to admin_order_path(params[:id])
  end
end
