class Admin::UsersController < ApplicationController

  before_filter :authorize

  def users
    @users = User.find(session[:user_id]).company.users
  end
  
  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuario creado exitosamente"
      redirect_to :controller => 'admin', :action => 'users'
    else
      flash[:notice] = "Error creando usuario"
    end
  end
  
  def edit_user
    @user = User.find(params[:user])
  end
  
  def update_user
    @user= User.find([:user][:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuario actualizado exitosamente"
      redirect_to :controller => 'admin', :action => 'users'
    else
      flash[:notice] = "Error actualizando usuario"
    end
  end
  
  def delete_user
    User.destroy(params[:user])
    flash[:notice] = "Usuario eliminado"
    redirect_to :controller => 'admin', :action=> 'users'
  end

end
