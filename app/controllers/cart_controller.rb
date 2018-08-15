class CartController < ApplicationController
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

  def checkout
  end
end
