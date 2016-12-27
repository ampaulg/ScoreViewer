class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :login_required
    helper_method :logged_in?, :current_player

    def login_required
        if !logged_in?
            redirect_to login_path, :notice=> "You need to log in first"
        end
    end
    
    def logged_in?
        !!session[:player_id]
    end
  
    def current_user
        if session[:player_id]
            @current_player =  User.find(session[:player_id])
            @current_player
        else
            false
        end
    end
  
end
