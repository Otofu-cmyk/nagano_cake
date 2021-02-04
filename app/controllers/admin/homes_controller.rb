class Admin::HomesController < ApplicationController
  def top
    def url_check
      if params[:url]=="admin_customer_path"
        order=Order.where(customer_id: params[:number])
      else
        order=Order.all
      end
      return order
    end
    @order=url_check.page(params[:page]).per(10)
    @ordered_products=OrderedProduct.all
  end
end
