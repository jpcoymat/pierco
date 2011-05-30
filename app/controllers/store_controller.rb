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
    @product_subcategories = ProductSubcategory.where(:product_category_id => params[:product_category])
    product_subcategory = params[:product_subcategory] || @product_subcategories.first.id
    @page = params[:page] || 1
    @products = Product.where(:product_category_id => params[:product_category], :product_subcategory_id => product_subcategory).paginate(:page => @page, :order => 'name ASC', :per_page => 6)
  end
  
  def distributors
    @company = Company.first
    @cities = Distributor.find_by_sql("select distinct city from distributors where company_id = #{@company.id} order by city")
  end
  
  def contact_us
    @company = Company.first  

  end
  
  def view_product
    @company = Company.first
    @product = Product.find(params[:product])
  end



end
