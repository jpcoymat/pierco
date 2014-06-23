class Admin::DistributorsController < ApplicationController

  before_filter :authorize
  layout 'admin'

  def index
    @distributors = User.find(session[:user_id]).company.distributors
  end
  
  def new
    @company = User.find(session[:user_id]).company
    @distributor = Distributor.new
  end
  
  def show
    @distributor = Distributor.find(params[:id])
  end
  
  
  def create
    @distributor = Distributor.new(params[:distributor])
    if @distributor.save
      flash[:notice] = "Distrtibuidor creado exitosamente"
      redirect_to admin_distributors_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @distributor = Distributor.find(params[:id])
  end
  
  def update
    @distributor = Distributor.find(params[:id])
    if @distributor.update_attributes(params[:distributor])
      flash[:notice] = "Distribuidor actualizado exitosamente"
      redirect_to admin_distributors_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    Distributor.destroy(params[:id])
    flash[:notice] = "Distribuidor eliminado exitosamente"
    redirect_to admin_distributors_path
  end
  
end
