class JavascriptsController < ApplicationController
  
  def dynamic_subcategories
    @subcategories = User.find(session[:user_id]).company.product_subcategories
    
  end

end
