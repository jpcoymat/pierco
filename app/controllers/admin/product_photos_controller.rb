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
  end

  def create
    @product_photo = ProductPhoto.new(product_photo_parms)
    respond_to do |format|
      if @product_photo.save
        format.json { render json: @product_photo, status: :ok}
        format.js
      else
        format.json { render json: @product_photo.errors, status: :unprocessable_entity }
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
      params.require(:product_photo).permit()
    end

end
