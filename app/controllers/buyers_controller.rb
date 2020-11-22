class BuyersController < ApplicationController
  before_action :authenticate_buyer
  
  def index
    @products = Product.where(status: "approved")
  end
  
end
