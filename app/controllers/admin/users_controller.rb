class Admin::UsersController < ApplicationController

  layout 'admin'
  before_action :set_user, only: [:edit, :update, :destroy]

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
      flash[:alert] = "Error creando usuario"
    end
  end
  
  def edit
    
  end
  
  def update
    @user.assign_attributes(params[:user])
    if @user.valid?
      ChangeLog.record_changes_on(@user, User.find(session[:user_id]))
      @user.save
      flash[:notice] = "Usuario actualizado exitosamente"
      redirect_to admin_users_path
    else
      flash[:alert] = "Error actualizando usuario"
      render action: 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "Usuario eliminado"
    redirect_to admin_users_path
  end

  private
    
    def set_user
      @user = User.find(params[:id])
    end
  

end
