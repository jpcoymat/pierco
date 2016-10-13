class Admin::ProductCategoriesController < ApplicationController

  layout 'admin'

  before_action :set_product_category, only: [:show, :edit, :update, :destroy]

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
      flas[:alert] = "Error creando categoria"
      @company = User.find(session[:user_id]).company
      render :action => 'new_product_category'
    end
  end
  
  def edit

  end
  
  def update
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Categoria actalizada exitosamente"
      redirect_to admin_product_categories_path
    else
      flash[:alert] = "Error actualizando categoria"
      render :action => 'edit'      
    end
  end
  
  def destroy
    @product_category.destroy
    flash[:notice] = "Catgoria eliminada exitosamente"
    redirect_to admin_product_categories_path
  end
  
  private
  
  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end


end

  
