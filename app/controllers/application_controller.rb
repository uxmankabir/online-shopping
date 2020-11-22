class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    if logged_in?
      if current_user.role == "admin"
        redirect_to all_admins_path
      elsif current_user.role == "buyer"
        redirect_to buyers_path
      elsif current_user.role == "seller"
        redirect_to approved_sellers_path
      end
    end
  end
  
  def authenticate_admin
    if logged_in?
      if current_user.role == "buyer"
        redirect_to buyers_path
      elsif current_user.role == "seller"
        redirect_to approved_sellers_path
      end
    else
      redirect_to sign_in_path
    end
  end

  def authenticate_buyer
    if logged_in?
      if current_user.role == "admin"
        redirect_to all_admins_path
      elsif current_user.role == "seller"
        redirect_to approved_sellers_path
      end
    else
      redirect_to sign_in_path
    end
  end

  def authenticate_seller
    if logged_in?
      if current_user.role == "admin"
        redirect_to all_admins_path
      elsif current_user.role == "buyer"
        redirect_to buyers_path
      end
    else
      redirect_to sign_in_path
    end
  end

end
