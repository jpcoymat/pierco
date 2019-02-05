class Admin::ProductCategoriesController < ApplicationController

  layout 'admin'

  before_action :set_product_category, only: [:show, :edit, :update, :destroy]
  
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end
  

  def index
    @product_categories = User.find(session[:user_id]).company.product_categories
  end
  
  def new
    @company = User.find(session[:user_id]).company
    @product_category = ProductCategory.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @product_category = ProductCategory.new(params[:product_category])
    respond_to do |format|
      if @product_category.save
        format.html do
          flash[:notice] = "Categoria creada exitosamente"
          redirect_to admin_product_categories_path
        end
        format.js do
          @product_categories = ProductCategory.where(company_id: session[:company_id])
        end
      else
        format.hmtl do
          flash[:alert] = "Error creando categoria"
          @company = User.find(session[:user_id]).company
          render action: 'new_product_category'
        end
        format.js do
          render action: 'errors'
        end
      end
    end
  end
  
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    respond_to do |format|
      if @product_category.update_attributes(params[:product_category])
        format.html do
          flash[:notice] = "Categoria actalizada exitosamente"
          redirect_to admin_product_categories_path
        end
        format.js do
          @product_categories = ProductCategory.where(company_id: session[:company_id])
        end
      else
        format.html do
          flash[:alert] = "Error actualizando categoria"
          render :action => 'edit'      
        end
        format.js do
          render action: 'errors'
        end
      end      
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

  
