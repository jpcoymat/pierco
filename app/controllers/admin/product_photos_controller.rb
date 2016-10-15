class Admin::ProductPhotosController < ApplicationController

  layout 'admin'

  before_action :set_product_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_product

  def index
    @product_photos = @product.product_photos
  end

  def show
  
  end

  def new
    @product_photo = ProductPhoto.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @product_photo = ProductPhoto.new(product_photo_parms)
    @product_photo.product = @product
    respond_to do |format|
      if @product_photo.save
        format.json { render json: @product_photo, status: :ok}
        format.js
        format.html do
          flash[:notice] = "Archivo cargado exitosamente"
          redirect_to admin_product_path(@product)
        end
      else
        format.json { render json: @product_photo.errors, status: :unprocessable_entity }
        format.html do 
          flash[:alert] = "Error cargando archivo"
          redirect_to admin_product_path(@product)
        end
      end
    end
  end

  def edit
  
  end

  def update
    if @product_photo.update_attributes(product_photo_parms)
    end
  end

  def destroy
    @product_photo.destroy
  end

  private

    def set_product_photo
      @product_photo = ProductPhoto.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def product_photo_parms
      params.require(:product_photo).permit(:product_photograph)
    end

end
