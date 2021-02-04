class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    def method_address
      addresses=Address.all
      array_addresses=[]
      addresses.each do |address|
        array_addresses.push("〒#{address.postal_code} #{address.address}　#{address.name}")
      end
      return array_addresses
    end
    @addresses=method_address
  end

  def orderconfirmation
    @cart_items=CartItem.all

    def total_amount
      count=0
      @cart_items.each do |cart_item|
        count+=cart_item.item.price*1.1*cart_item.amount
      end
      return count
    end
    @total_amount=total_amount

    def payment_method
      if params["payment_method"]=="クレジットカード"
        payment_method="クレジットカード"
      else
        payment_method="銀行振込"
      end
      return payment_method
    end
    @payment_method=payment_method

    addresses=Address.all
    if params["radio_address"]=="customer_address"
      postal_code=current_customer.postal_code
      address=current_customer.address
      name="#{current_customer.last_name}#{current_customer.first_name}"
    elsif params["radio_address"]=="address_address"
      addresses.each do |block_address|
        if params["address_address"]=="〒#{block_address.postal_code} #{block_address.address}　#{block_address.name}"
          postal_code=block_address.postal_code
          address=block_address.address
          name=block_address.name
        end
      end
    else
      postal_code=params[:postal_code]
      address=params[:address]
      name=params[:name]
    end
    @postal_code=postal_code
    @address=address
    @name=name

    @order=Order.new
  end

  def ordercomplete
  end

  def create
    cart_items=CartItem.all
    order=Order.new(order_params)
    order.save!
    cart_items.each do |cart_item|
      ordered_product=OrderedProduct.new
      ordered_product.order_id=order.id
      ordered_product.item_id=cart_item.item.id
      ordered_product.price=cart_item.item.price*1.1
      ordered_product.quantity=cart_item.amount
      ordered_product.save!
    end

    cart_items.each do |cart_item|
      cart_item.destroy
    end

    redirect_to orders_ordercomplete_path
  end

  def index
    @orders=Order.all
    @ordered_products=OrderedProduct.all
  end

  def show
    @order=Order.find(params[:id])
    @ordered_products=OrderedProduct.where(order_id: params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id , :shipping_postal_code , :shipping_address , :shipping_name , :payment_method , :billing_amount , :shipping)
  end
end
