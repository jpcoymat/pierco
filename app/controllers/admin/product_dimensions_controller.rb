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
    if @product_dimension.save
      @product = @product_dimension.product
      flash[:notice] = "Dimension creada exitosamente"
      respond_to do |format|
        format.html {redirect_to admin_product_path @product.id}
        format.js 
      end
    else
      respond_to do |format|
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
  end
  
  def update
    @product_dimension = ProductDimension.find(params[:id])
    @product = @product_dimension.product
    if @product_dimension.update_attributes(params[:product_dimension])
      flash[:notice] = "Dimension actualizada exitosamente"
      redirect_to admin_product_path(@product)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = ProductDimension.find(params[:id]).product
    ProductDimension.destroy(params[:id])
    flash[:notice] = "Dimension eliminada exitosamente"
    redirect_to admin_product_path(@product)
  end
  
end
