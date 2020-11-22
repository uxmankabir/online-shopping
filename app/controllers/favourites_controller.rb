class FavouritesController < ApplicationController
  before_action :authenticate_buyer

  def index
    @favourites = Favourite.where(user_id: current_user.id)
  end

  def add
    favourite = Favourite.new(user_id: current_user.id, product_id: params[:id])
    if favourite.save
      flash[:success] = "Product has been added to favourite successfully." 
    else
      flash[:danger] = "Product has not been added to favourite." 
    end
    redirect_to favourites_path
  end

  def destroy
    Favourite.find_by(id: params[:id]).destroy
    flash[:success] = "Product has been removed from favourite successfully." 
    redirect_to favourites_path
  end
  
end
