class ApplicationController < ActionController::Base
  before_action :authorize
  
  protected
    
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_login_path 
      end
    end
    
    
    
end
