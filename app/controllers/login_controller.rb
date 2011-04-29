class LoginController < ApplicationController
  
  before_filter :authorize, :except => [:login]

  def login
    if request.post?
      @user = User.authenticate(params[:user_login][:username],params[:user_login][:password])
      if @user
        flash[:notice] = "Bienvenido!"
        session[:user_id] = @user.id
        redirect_to :controller => 'admin', :action => 'index'
      else
        flash[:notice] ="Usuario/contrasena invalida"
        redirect_to :controller => 'login', :action => 'login'
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Su sesion ha terminado"
    redirect_to :controller => 'login', :action => 'login'
  end

end
