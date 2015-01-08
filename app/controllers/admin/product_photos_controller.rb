class Admin::ProductPhotosController < ApplicationController
  
  layout 'admin'
  before_filter :authorize

  def new
   @product = Product.find(params[:product_id])
   @product_photo = ProductPhoto.new
  end

  def create
    @product_photo  = ProductPhoto.new(params[:product_photo])
    if @product_photo.save
      flash[:notice] = "Dimension creada exitosamente"
      redirect_to admin_product_path @product_photo.product_id
    else
      @product = Product.find(params[:product_photo][:product_id])
      render :action => 'new'
    end
  end

  def edit
    @product_photo = ProductPhoto.find(params[:id])
    @product = @product_photo.product
  end

  def update
    @product_photo = ProductPhoto.find(params[:id])
    @product = @product_photo.product
    if @product_photo.update_attributes(params[:ProductPhoto])
      flash[:notice] = "Dimension actualizada exitosamente"
      redirect_to admin_product_path(@product)
    else
      render :action => 'edit'
    end
  end

   def destroy
     @product = ProductPhoto.find(params[:id]).product
     ProductPhoto.destroy(params[:id])
     flash[:notice] = "Foto eliminada exitosamente"
     redirect_to admin_product_path(@product)
   end
  
end
   
  