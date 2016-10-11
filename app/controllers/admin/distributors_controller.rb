class Admin::DistributorsController < ApplicationController

  layout 'admin'

  def lookup
    @user = User.find(session[:user_id])
    @company = @user.company
    @cities = @company.distributor_cities    
    @all_distributors = @company.distributors
    if request.post?
      search_params = distributor_params.clone
      search_params.delete_if {|k,v,| v.blank?} 
      @distributors = Distributor.where(search_params)
    end
  end

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
      redirect_to lookup_admin_distributors_path
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
      redirect_to lookup_admin_distributors_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    Distributor.destroy(params[:id])
    flash[:notice] = "Distribuidor eliminado exitosamente"
    redirect_to lookup_admin_distributors_path
  end
  
  private 
    
     def distributor_params
       params.require(:distributor).permit(:name, :city)
     end

end
