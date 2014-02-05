class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  private

  def current_cart
	  cart = Cart.create
	  session[:cart_id] = cart.id
	  cart
  end

end
