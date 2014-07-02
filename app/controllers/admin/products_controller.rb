class Admin::ProductsController < ApplicationController

  layout 'admin'
  before_filter :authorize

  def lookup 
    @suppliers = User.find(session[:user_id]).company.suppliers
    @product_categories = User.find(session[:user_id]).company.product_categories
    @product_subcategories = User.find(session[:user_id]).company.product_subcategories
    @all_products = User.find(session[:user_id]).company.products
    if request.post?
      product_search = params[:product].clone
      product_search.delete_if {|k,v| v.blank? }
      @products = Product.where(product_search).order('name ASC').all
    end
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
  end
  
  def create
    picture_file = params[:product][:image_file]
    params[:product].delete("image_file")
    @product = Product.new(params[:product])
    @product.set_picture_file(picture_file) if picture_file  
    if @product.save        
      flash[:notice] = "Producto creado exitosamnte"
      redirect_to admin_product_path @product
    else
      @company = User.find(session[:user_id]).company
      @suppliers = @company.suppliers
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      render :action => 'new'
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
    picture_file = params[:product][:image_file]
    params[:product].delete("image_file")
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      @product.set_picture_file(picture_file) if picture_file          
      flash[:notice] = "Producto actualizado exitosamente"
      redirect_to admin_product_path @product
    else
      @company = User.find(session[:user_id]).company
      @suppliers = @company.suppliers
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      render :action => 'edit'    
    end
  end
  
  def destroy
    Product.destroy(params[:id])
    flash[:notice] ="Producto eliminado exitosamente"
    redirect_to lookup_admin_products_path
  end


end
