class SellersController < ApplicationController
  before_action :authenticate_seller
  
  def approved
    @products = Product.where(user: current_user, status: "approved")
  end
  def pending
    @products = Product.where(user: current_user, status: "pending")
  end
  def rejected
    @products = Product.where(user: current_user, status: "rejected")
  end
  
end
