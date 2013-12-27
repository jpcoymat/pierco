class Admin::CompaniesController < ApplicationController

  before_filter :authorize

  def index
    @company = User.find(session[:user_id]).company
  end
  
  def new
    @company = Company.new
  end
  
  def edit
    @company = Company.find(params[:company])
  end
  
  def update
    @company = Company.find(params[:company][:id])
    picture_file = params[:company][:logo_picture] if !(params[:company][:logo_picture].nil?)
    params[:company].delete("logo_picture")
    if @company.update_attributes(params[:company])
      if picture_file
        @company.set_picture_file(picture_file)
      end
      flash[:notice] = "Compa&ntilde;ia actualizada exitosamente".html_safe
      redirect_to admin_company_index_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Compa&ntilde;ia creada exitosamente"
      redirect_to admin_company_index_path
    else
      flash[:notice] = "Error creando Compa&ntilde;ia"
      render action: 'new'
    end
    
  end

  
end
