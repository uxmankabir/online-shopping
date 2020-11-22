class AdminsController < ApplicationController
  before_action :authenticate_admin
  
  def all
    @products = Product.all
  end
  def pending
    @products = Product.where(status: "pending")
  end
  def approved
    @products = Product.where(status: "approved")
  end
  def rejected
    @products = Product.where(status: "rejected")
  end
  
end
