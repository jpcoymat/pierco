class Admin::ProductSubcategoriesController < ApplicationController

  before_filter :authorize
  layout 'admin'
  def index
     @product_category = ProductCategory.find(params[:product_category_id])
     @product_subcategory = ProductSubcategory.new
   end

   def new
     @product_category = ProductCategory.find(params[:product_category_id])
     @product_subcategory = ProductSubcategory.new
   end

   def create
     @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
     if @product_subcategory.save
       flash[:notice] = "Subcategoria creada exitosamente"
     end
     redirect_to admin_product_category_product_subcategories_path(@product_subcategory.product_category_id)
   end

   def edit
     @product_subcategory = ProductSubcategory.find(params[:id])
     @product_category = @product_subcategory.product_category
   end

   def update
     @product_subcategory = ProductSubcategory.find(params[:product_subcategory][:id])
     if @product_subcategory.update_attributes(params[:product_subcategory])
       flash[:notice] = "Subcategoria actualizada exitosamente"
       redirect_to admin_product_category_product_subcategories_path(@product_subcategory.product_category_id)
     else
       render :action => 'edit'
     end
   end

   def destroy
     product_category = ProductSubcategory.find(params[:product_subcategory]).product_category
     ProductSubcategory.destroy(params[:product_subcategory])
     flash[:notice] = "Subcategoria eliminada exitosamente"
     redirect_to admin_product_category_product_subcategories_path @product_subcategory.product_category_id
   end
  

end
