class StoreController < ApplicationController

  def index
    @company = Company.first
  end
  
  def about_us
    @company = Company.first
  end
  
  def suppliers
    @company = Company.first
    @suppliers= @company.suppliers
  end
  
  def products
    @company = Company.first
    @products = Product.where(:product_category_id => params[:product_category]).all  
  end
  
  def distributors
    @company = Company.first
    @cities = Distributor.find_by_sql("select distinct city from distributors where company_id = #{@company.id} order by city")
  end
  
  def contact_us
    @company = Company.first  

  end



end
