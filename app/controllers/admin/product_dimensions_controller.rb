class Admin::ProductDimensionsController < ApplicationController
  
  layout 'admin'
  before_filter :authorize
  
  def new
    @product = Product.find(params[:product_id])
    @product_dimension = ProductDimension.new
  end

  def create
    @product_dimension = ProductDimension.new(params[:product_dimension])
    if @product_dimension.save
      flash[:notice] = "Dimension creada exitosamente"
      redirect_to admin_product_path @product_dimension.product_id
    else
      @product = Product.find(params[:product_dimension][:product_id])
      render :action => 'new'
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
