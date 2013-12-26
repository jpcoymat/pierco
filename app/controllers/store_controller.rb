class StoreController < ApplicationController

  def index
    @company = Company.first
    @products = @company.products
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
    product_category = params[:product_category] || @company.product_categories.first
    @product_subcategories = ProductSubcategory.where(:product_category_id => product_category)
    product_subcategory = params[:product_subcategory] || @product_subcategories.first.id
    @page = params[:page] || 1
    @products = Product.where(:product_category_id => product_category, :product_subcategory_id => product_subcategory).paginate(:page => @page, :order => 'supplier_id ASC, name ASC', :per_page => 6)
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

  def create_contact
    @company = Company.first
    @contact = Contact.new(params[:contact])
    if @contact.save
      Notifier.customer_feedback_received(@contact).deliver
      redirect_to :action =>'thank_you'
    else      
      render :action => 'contact_us'
    end
  end
  
  def thank_you
    @company = Company.first
  end



end
