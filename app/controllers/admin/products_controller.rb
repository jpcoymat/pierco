class Admin::ProductsController < ApplicationController

  layout 'admin'
  before_filter :authorize

  def lookup 
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
    @all_products = @company.products
    if request.post?
      product_search = params[:product].clone
      product_search.delete_if {|k,v| v.blank? }
      @products = Product.where(product_search).order('name ASC').all
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
  
  def show
    @product = Product.find(params[:id])
    @product_photo = ProductPhoto.new
  end
  
  def new
    @product = Product.new
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save        
      flash[:notice] = "Producto creado exitosamnte"
      redirect_to admin_product_path @product
    else
      @company = User.find(session[:user_id]).company
      @suppliers = @company.suppliers
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      render action: 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product]) 
      flash[:notice] = "Producto actualizado exitosamente"
      redirect_to admin_product_path @product
    else
      @company = User.find(session[:user_id]).company
      @suppliers = @company.suppliers
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      render action: 'edit'    
    end
  end
  
  def destroy
    Product.destroy(params[:id])
    flash[:notice] ="Producto eliminado exitosamente"
    redirect_to lookup_admin_products_path
  end
  
  
  def search
    product_search = params[:product].clone
    product_search.delete_if {|k,v| v.blank? }
    @products = Product.where(product_search).order('name ASC').all
    respond_to do |format|
      #format.html
      format.js
    end
  end


end
