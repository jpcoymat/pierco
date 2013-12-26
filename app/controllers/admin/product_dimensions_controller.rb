class Admin::ProductDimensionsController < ApplicationController
  
  before_filter :authorize
  
  def new
    @product = Product.find(params[:product])
    @product_dimension = ProductDimension.new
  end

  def create
    @product_dimension = ProductDimension.new(params[:product_dimension])
    if @product_dimension.save
      flash[:notice] = "Dimension creada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_product', :product=> @product_dimension.product
    else
      @product = Product.find(params[:product_dimension][:product_id])
      render :action => 'new_product_dimension'
    end
  end
  
  def edit
    @product_dimension = ProductDimension.find(params[:product_dimension])
    @product = @product_dimension.product
  end
  
  def update
    @product_dimension = ProductDimension.find(params[:product_dimension][:id])
    if @product_dimension.update_attributes(params[:product_dimension])
      flash[:notice] = "Dimension actualizada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_product', :product => @product_dimension.product
    else
      @product = Product.find(params[:product_dimension][:product_id])
      render :action => 'edit_product_dimension'
    end
  end
  
  def delete
    @product = Product.find(params[:product_dimension][:product_id])
    ProductDimension.destroy(params[:product_dimension])
    flash[:notice] = "Dimension eliminada exitosamente"
    redirect_to :controller => 'admin', :action => 'view_product', :product => @product
  end
  
end
