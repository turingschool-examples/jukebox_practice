class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_admin
    render file: '/public/404' unless current_admin?
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end
end
