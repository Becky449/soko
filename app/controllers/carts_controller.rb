class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def add_item
    cart = current_user.cart || current_user.create_cart
    item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    item.quantity += params[:quantity].to_i
    item.save
    redirect_to cart_path, notice: 'Item added to cart!'
  end

  def remove_item
    item = CartItem.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: 'Item removed from cart!'
  end
end
