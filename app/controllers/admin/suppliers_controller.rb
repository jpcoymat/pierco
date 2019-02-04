class Admin::SuppliersController < ApplicationController
  
  layout 'admin'
  before_action :set_supplier, only: [:edit, :update, :delete, :show]

  def index
    @suppliers = User.find(session[:user_id]).company.suppliers
  end
  
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @supplier = Supplier.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    respond_to do |format|
      if @supplier.save
        format.html do
          flash[:notice] = "Marca creada exitosamente"
          redirect_to admin_supplier_path @supplier
        end
        format.js do 
          @suppliers = User.find(session[:user_id]).company.suppliers
        end 
      else
        format.html do
          flash[:alert] = "Error creando marca"
          render action: 'new'
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
    @supplier.assign_attributes(params[:supplier])
    respond_to do |format|
      if @supplier.save
        format.html do
          flash[:notice] = "Marca actualizada exitosamente"
          redirect_to admin_supplier_path @supplier
        end
        format.js do 
          @suppliers = User.find(session[:user_id]).company.suppliers
        end 
      else
        format.html do 
          flash[:alert] = "Error actualizando marca"
          render action: 'edit'
        end
        format.js do
          render action: 'errors'
        end
      end      
    end
  end
  
  def destroy
    Supplier.destroy(params[:id])
    flash[:notice] = "Marca eliminada exitosamente"
    redirect_to admin_suppliers_path
  end
  
  private 

    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

 
end
