class Admin::DistributorsController < ApplicationController

  before_filter :authorize

  def index
    @distributors = User.find(session[:user_id]).company.distributors
  end
  
  def new
    @company = User.find(session[:user_id]).company
    @distributor = Distributor.new
  end
  
  def show
    @distributor = Distributor.find(params[:distributor])
  end
  
  
  def create
    @distributor = Distributor.new(params[:distributor])
    if @distributor.save
      flash[:notice] = "Distrtibuidor creado exitosamente"
      redirect_to admin_distributor_index_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @distributor = Distributor.find(params[:distributor])
  end
  
  def update
    @distributor = Distributor.find(params[:distributor][:id])
    if @distributor.update_attributes(params[:distributor])
      flash[:notice] = "Distribuidor actualizado exitosamente"
      redirect_to admin_distributor_index_path
    else
      render :action => 'edit'
    end
  end
  
  def delete
    Distributor.destroy(params[:distributor])
    flash[:notice] = "Distribuidor eliminado exitosamente"
    redirect_to admin_distributor_index_path
  end
  
end
