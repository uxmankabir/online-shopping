class SessionsController < ApplicationController
  layout 'intro', :only => [:new]
  before_action :authenticate, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present? && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in successfully"
      authenticate
    else
      flash.now[:danger] = "Your email or password is incorrect"
      render 'new', layout: 'intro'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully"
    redirect_to sign_in_path
  end

end