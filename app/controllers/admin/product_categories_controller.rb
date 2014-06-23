class Admin::ProductCategoriesController < ApplicationController

  before_filter :authorize
  layout 'admin'

  def index
    @product_categories = User.find(session[:user_id]).company.product_categories
  end
  
  def new
    @company = User.find(session[:user_id]).company
    @product_category = ProductCategory.new
  end
  
  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      flash[:notice] = "Categoria creada exitosamente"
      redirect_to admin_product_categories_path
    else
      @company = User.find(session[:user_id]).company
      render :action => 'new_product_category'
    end
  end
  
  def edit
    @product_category = ProductCategory.find(params[:id])
  end
  
  def update
    @product_category = ProductCategory.find(params[:id])
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Categoria actalizada exitosamente"
      redirect_to admin_product_categories_path
    else
      render :action => 'edit'      
    end
  end
  
  def destroy
    ProductCategory.destroy(params[:id])
    flash[:notice] = "Catgoria eliminada exitosamente"
    redirect_to admin_product_categories_path
  end


end

  
