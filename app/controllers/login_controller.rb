class LoginController < ApplicationController
  
  before_action :authorize, :except => [:login]

  def login
    if request.post?
      @user = User.where(username: params[:user_login][:username]).first
      if @user.try(:authenticate, params[:user_login][:password])
        flash[:notice] = "Bienvenido!"
        session[:user_id] = @user.id
        session[:company_id] = @user.company.id
        redirect_to admin_companies_path
      else
        flash[:notice] ="Usuario/contrasena invalida"
        redirect_to login_login_path
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:company_id] = nil
    flash[:notice] = "Su sesion ha terminado"
    redirect_to login_login_path
  end

end
