class ProductsController < ApplicationController
  before_action :authenticate_seller, only: [:new, :create]
  before_action :authenticate_admin, only: [:approve, :reject]
  
  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    3.times { @product.images.build }
  end

  def create
    params[:product][:user_id] = current_user.id
    params[:product][:status] = "pending"
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Your product has been created successfully." 
      redirect_to pending_sellers_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    params[:product][:status] = "pending"
    @product = Product.find_by(id: params[:id])
    if @product.update(product_update_params)
      flash[:success] = "Your product has been updated successfully." 
      redirect_to pending_sellers_path
    else
      redirect_to edit_product_path
    end
  end

  def destroy
    Product.find_by(id: params[:id]).destroy
    flash[:success] = "Product has been deleted successfully." 
    redirect_to approved_sellers_path
  end

  def approve
    product = Product.find_by(id: params[:id])
    product.update(status: "approved")
    flash[:success] = "Product has been approved successfully." 
    redirect_to approved_admins_path
  end

  def reject
    product = Product.find_by(id: params[:id])
    product.update(status: "rejected")
    flash[:success] = "Product has been rejected successfully." 
    redirect_to rejected_admins_path
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :status, :user_id, images_attributes: [:id, :picture])
  end

  def product_update_params
    params.require(:product).permit(:name, :price, :description, :status)
  end

end
