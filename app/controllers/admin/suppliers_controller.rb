class Admin::SuppliersController < ApplicationController
  
  layout 'admin'
  before_action :set_supplier, only: [:edit, :update, :delete, :show]

  def index
    @suppliers = User.find(session[:user_id]).company.suppliers
  end
  
  def show
    
  end

  def new
    @supplier = Supplier.new
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:notice] = "Marca creada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
      flas[:alert] = "Error creando marca"
      render action: 'new'
    end
  end
  
  def edit
    
  end

  def update
    @supplier.assign_attributes(params[:supplier])
    if @supplier.save
      flash[:notice] = "Marca actualizada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
      flash[:alert] = "Error actualizando marca"
      render action: 'edit'
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
