class PagesController < ApplicationController  
  def home
    redirect_to listings_path if current_user
  end
end
