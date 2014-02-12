class FosterController < ApplicationController
  def index
	  @pets = Pet.all
	  @cart = current_cart
  end
end
