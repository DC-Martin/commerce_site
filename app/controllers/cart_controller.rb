class CartController < ApplicationController

  before_action :authenticate_user!, except: [:add_to_cart, :view_order]

  def add_to_cart
    check = LineItem.find_by(product_id: params[:product_id])
    if check
      check.update(quantity: (check.quantity + params[:quantity].to_i))
      check.update(line_item_total: (check.quantity * check.product.price))
    else
      line_item = LineItem.create(product_id: params[:product_id], quantity: params[:quantity])
      line_item.update(line_item_total: (line_item.quantity * line_item.product.price))
    end
    redirect_back(fallback_location: root_path)
  end

  def view_order
    @line_items = LineItem.all
  end

  def cart_edit
    
  end

  def cart_delete
    
  end

  def checkout
    line_items = LineItem.all
    @order = Order.create(user_id: current_user.id, subtotal: 0)
    line_items.each do |item|
      item.product.update(quantity: (item.product.quantity - item.quantity))
      @order.order_items[item.product_id] = item.quantity
      @order.subtotal += item.line_item_total
    end
    @order.save
    @order.update(sales_tax: (@order.subtotal * 0.08))
    @order.update(grand_total: (@order.sales_tax + @order.subtotal))

    line_items.destroy_all
  end
end
