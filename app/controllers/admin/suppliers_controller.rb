class Admin::SuppliersController < ApplicationController
  
  before_filter :authorize

  def index
    @suppliers = User.find(session[:user_id]).company.suppliers
  end
  
  def show
    @supplier = Supplier.find(params[:supplier])
  end

  def new
    @supplier = Supplier.new
  end
  
  def create
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    params[:supplier].delete("logo_picture")
    @supplier = Supplier.new(params[:supplier])
    @supplier.set_picture_file(picture_file) if picture_file
    if @supplier.save
      flash[:notice] = "Marca creada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
      render :action => 'new'
    end
  end
  
  def edit
    @supplier = Supplier.find(params[:supplier])
  end

  def update
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    @supplier = Supplier.find(params[:supplier][:id])
    params[:supplier].delete("logo_picture")
    if @supplier.update_attributes(params[:supplier])
      @supplier.set_picture_file(picture_file) if picture_file
      flash[:notice] = "Marca actualizada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    Supplier.destroy(params[:supplier])
    flash[:notice] = "Marca eliminada exitosamente"
    redirect_to admin_suppliers_path
  end
   
end
