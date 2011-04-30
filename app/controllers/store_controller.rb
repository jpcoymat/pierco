class StoreController < ApplicationController

  def index
    @company = Company.first
  end
  
  def about_us
    @company = Company.first
  end
  
  def suppliers
    @company = Company.first
    @suppliers = @company.suppliers
  end
  
  def products
    @company = Company.first
    @products = @company.active_products
  end
  
  def distributors
    @company = Company.first
    @distributors = @company.distributors
  end
  
  def contact_us
    @company = Company.first  

  end



end
