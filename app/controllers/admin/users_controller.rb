class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authorize

  def index 
    @users = User.find(session[:user_id]).company.users
  end
  
  def new
    @user = User.new
    @company = User.find(session[:user_id]).company
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuario creado exitosamente"
      redirect_to admin_users_path
    else
      flash[:notice] = "Error creando usuario"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user= User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuario actualizado exitosamente"
      redirect_to admin_users_path
    else
      flash[:notice] = "Error actualizando usuario"
      render action: 'edit'
    end
  end
  
  def destroy
    User.destroy(params[:user])
    flash[:notice] = "Usuario eliminado"
    redirect_to admin_users_path
  end

end
