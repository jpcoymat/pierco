class Admin::ProductsController < ApplicationController

  layout 'admin'

  def lookup 
    set_filter_criteria
    @all_products = @company.products
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    set_filter_criteria
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save        
      flash[:alert] = nil
      flash[:notice] = "Producto creado exitosamnte"
      render action: 'show'
    else
      flash[:notice] = nil
      flash[:alert] = "Error creando producto"
      set_filter_criteria
      render action: 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    set_filter_criteria
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product]) 
      flash[:alert] = nil
      flash[:notice] = "Producto actualizado exitosamente"
      render action: 'show'
    else
      flash[:notice] = nil
      flash[:alert] = "Error actualizando producto"
      set_filter_criteria
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
  
  private 
  
  def set_filter_criteria
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories    
  end


end
