class StoreController < ApplicationController

  skip_before_action :authorize
  
  def index
    @company = Company.first
    @suppliers = @company.suppliers
    render layout: false
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
    @product_categories = @company.product_categories
    @suppliers = @company.suppliers
    params[:product_category_id].nil? ? @product_category = @product_categories.first : @product_category = ProductCategory.find(params[:product_category_id])
    params[:supplier_id].nil? ? @supplier = @suppliers.first : @supplier = Supplier.find(params[:supplier_id])
    @page = params[:page] || 1
    @products = Product.where(product_category_id: @product_category.id, supplier_id: @supplier.id).paginate(page: @page, per_page: 9).order('name ASC')
    respond_to do |format|
      format.html
      format.js 
    end
  end
    
  
  def distributors
    @company = Company.first
    @cities = @company.distributor_cities
    @city = nil
    @distributors = nil
    @distributor = nil
    if params[:city].nil? and params[:distributor].nil?
      @distributor = @company.default_distributor
      @city = @distributor.city
      @distributors = @company.distributor_by_city(@city)
    elsif !(params[:city].nil?) and params[:distributor].nil?
      @city = params[:city]
      @distributors = @company.distributor_by_city(@city)
      @distributor = @distributors.first
    elsif !(params[:distributor].nil?)
      @distributor = Distributor.find(params[:distributor])
      @city = @distributor.city
      @distributors = @company.distributor_by_city(@city) 
    end
  end
  
  def contact_us
    @company = Company.first  
    @contact = Contact.new
  end
  
  def view_product
    @company = Company.first
    @product = Product.find(params[:product])
  end
  
  def product_modal
    @product = Product.find(params[:product])
    respond_to do |format|
      format.html {render partial: "product_modal"}
      format.js
    end
  end
  
  def thank_you
    @company = Company.first
  end



end
