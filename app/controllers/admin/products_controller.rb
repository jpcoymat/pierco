class Admin::ProductsController < ApplicationController

  layout 'admin'
  
  before_action :set_product, only: [:show, :edit, :update]

  def lookup 
    set_filter_criteria
    @all_products = @company.products
  end
  
  def show
  end
  
  def new
    @product = Product.new
    set_filter_criteria
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @product = Product.new(params[:product])
    respond_to do |format|
      if @product.save     
        format.html do
          flash[:alert] = nil
          flash[:notice] = "Producto creado exitosamnte"
          render action: 'show'
        end   
        format.js
      else
        format.html do
          flash[:notice] = nil
          flash[:alert] = "Error creando producto"
          set_filter_criteria
          render action: 'new'          
        end
        format.js
      end      
    end
  end
  
  def edit
    set_filter_criteria
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    respond_to do |format|
      if @product.update_attributes(params[:product]) 
        format.html do
          flash[:alert] = nil
          flash[:notice] = "Producto actualizado exitosamente"
          render action: 'show'                    
        end
        format.js
      else
        format.html do
          flash[:notice] = nil
          flash[:alert] = "Error actualizando producto"
          set_filter_criteria
          render action: 'edit'    
        end
        format.js
      end      
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
  
  private 
  
  def set_filter_criteria
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories    
  end
  
  def set_product
    @product = Product.find(params[:id])
  end


end
