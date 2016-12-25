class SessionsController < ApplicationController
  skip_before_action :login_required, :only => [:new]
  
  def new
    @player = Player.new
  end

  def create
    player = Player.find_by_name(params[:name])
      if player && player.authenticate(params[:password])
        session[:player_id] = player.id
        redirect_to root_path, :notice => "Hello, #{player.name}"
      else
        flash.now.alert = "Invalid username or password"
        render "new"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  private
    def login(user)
      session[:user_id] = nil
    end

end
