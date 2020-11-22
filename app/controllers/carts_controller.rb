class CartsController < ApplicationController
  before_action :authenticate_buyer

  def index
    @carts = Cart.where(user_id: current_user.id)
    @total = 0
    @carts.each do |cart|
      @total = @total + cart.product.price
    end
  end

  def add
    cart = Cart.new(user_id: current_user.id, product_id: params[:id])
    if cart.save
      flash[:success] = "Product has been added to cart successfully." 
    else
      flash[:danger] = "Product has not been added to cart." 
    end
    redirect_to carts_path
  end

  def destroy
    Cart.find_by(id: params[:id]).destroy
    flash[:success] = "Product has been removed from cart successfully." 
    redirect_to carts_path
  end
  
end
