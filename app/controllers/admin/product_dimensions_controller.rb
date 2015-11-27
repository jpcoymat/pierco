class Admin::ProductDimensionsController < ApplicationController
  
  layout 'admin'
  before_filter :authorize
  
  def new
    @product = Product.find(params[:product_id])
    @product_dimension = ProductDimension.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def index
    @product = Product.find(params[:product_id])
    @product_dimensions = @product.product_dimensions
  end

  def create
    @product = Product.find(params[:product_id])
    @product_dimension = @product.product_dimensions.create(params[:product_dimension])
    respond_to do |format|
      if @product_dimension.save
        format.html do 
          redirect_to admin_product_path @product.id
          flash[:notice] = "Dimension creada exitosamente"
        end
        format.js
      else
        format.html do 
          render :action => 'new'
        end
        format.js
      end
    end
  end
  
  def edit
    @product_dimension = ProductDimension.find(params[:id])
    @product = @product_dimension.product
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    @product_dimension = ProductDimension.find(params[:id])
    @product = @product_dimension.product
    respond_to do |format|
      if @product_dimension.update_attributes(params[:product_dimension])
        format.html do
          flash[:notice] = "Dimension actualizada exitosamente"
          redirect_to admin_product_path(@product)  
        end
        format.js
      else
        format.html {render :action => 'edit'}
        format.js
      end
    end
  end
  
  def destroy
    @product = ProductDimension.find(params[:id]).product
    ProductDimension.destroy(params[:id])
    flash[:notice] = "Dimension eliminada exitosamente"
    redirect_to admin_product_path(@product)
  end
  
end
