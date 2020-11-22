class RegistrationsController < ApplicationController
  layout 'intro', :only => [:new]
  before_action :authenticate
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created successfully." 
      redirect_to sign_up_path
    else
      render :new, layout: 'intro'
    end
  end

  def validate_email
    user = User.find_by(email: params[:email])
    render json: {valid: !user.present?}
  end

  private

  def user_params
    params.require(:user).permit(:role, :first_name, :last_name, :email, :password)
  end


  
end