class Admin::SuppliersController < ApplicationController
  
  layout 'admin'
  before_filter :authorize
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
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    params[:supplier].delete("logo_picture")
    @supplier = Supplier.new(params[:supplier])
    @supplier.set_picture_file(picture_file) if picture_file
    if @supplier.save
      flash[:notice] = "Marca creada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
      render action: 'new'
    end
  end
  
  def edit
    
  end

  def update
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    params[:supplier].delete("logo_picture")
    @supplier.assign_attributes(params[:supplier])
    if @supplier.valid?
      ChangeLog.record_changes_on(@supplier, User.find(session[:user_id]))
      @supplier.set_picture_file(picture_file) if picture_file
      @supplier.save
      flash[:notice] = "Marca actualizada exitosamente"
      redirect_to admin_supplier_path @supplier
    else
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
