class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :login_required
    helper_method :logged_in?, :current_user

    def login_required
        if !logged_in?
            redirect_to login_path, :notice=> "You need to log in first"
        end
    end
    
    def logged_in?
        !!current_user
    end
  
    def current_user
        if session[:user_id]
            @current_user =  User.find(session[:user_id])
            @current_user
        else
            false
        end
    end
  
end
