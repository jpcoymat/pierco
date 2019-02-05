class Admin::ProductSubcategoriesController < ApplicationController

  layout 'admin'
  before_action :set_product_category
  before_action :set_product_subcategory, only: [:edit, :update]

  def index
    @product_subcategories = @product_category.product_subcategories
  end
  
  def new
    @product_subcategory = ProductSubcategory.new
    respond_to do |format|
      format.html
      format.js
    end
  end

   def create
     @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
     respond_to do |format|
       if @product_subcategory.save
         format.html do
           flash[:notice] = "Subcategoria creada exitosamente"
           redirect_to admin_product_category_product_subcategories_path(@product_subcategory.product_category_id)
         end
         format.js do
           @product_subcategories = @product_category.product_subcategories
         end
       else
         format.html do
           flash[:notice] = "Error creando subcategoria"
           redirect_to admin_product_category_product_subcategories_path(@product_subcategory.product_category_id)
         end
         format.js do
           render action: 'errors' 
         end
       end
       
     end
   end

   def edit
     respond_to do |format|
       format.js
       format.html
     end
   end

   def update
     respond_to do |format|
       if @product_subcategory.update_attributes(params[:product_subcategory])
         format.html do
           flash[:notice] = "Subcategoria actualizada exitosamente"
           redirect_to admin_product_category_product_subcategories_path(@product_subcategory.product_category_id)
         end
         format.js do
           @product_subcategories = @product_category.product_subcategories           
         end
       else
         format.html do
           render action: 'edit'
         end
         format.js do
           render action: 'errors'
         end
       end  
     end
   end

   def destroy
     ProductSubcategory.destroy(params[:id])
     flash[:notice] = "Subcategoria eliminada exitosamente"
     redirect_to(admin_product_category_product_subcategories_path(@product_category))
   end
   
   private 
   
   def set_product_category
     @product_category = ProductCategory.find(params[:product_category_id])
   end
   
   def set_product_subcategory
     @product_subcategory = ProductSubcategory.find(params[:id])
   end
  

end
