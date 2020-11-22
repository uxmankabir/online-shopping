class UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update!(user_params)
      flash[:success] = "User details has been updated successfully." 
      redirect_to users_path
    else
      flash[:danger] = "User details has not been updated." 
      redirect_to edit_user_path
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User has been deleted successfully." 
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end