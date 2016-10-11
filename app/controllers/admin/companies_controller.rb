class Admin::CompaniesController < ApplicationController

  layout 'admin'

  def index
    @company = User.find(session[:user_id]).company
  end
  
  def new
    @company = Company.new
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Compa&ntilde;ia actualizada exitosamente".html_safe
      redirect_to admin_companies_path
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
      redirect_to admin_companies_path
    else
      flash[:notice] = "Error creando Compa&ntilde;ia"
      render action: 'new'
    end
    
  end

  
end
