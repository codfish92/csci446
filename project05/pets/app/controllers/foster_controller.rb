class FosterController < ApplicationController
  def index
	  @pets = Pet.all
  end
end
