class SessionsController < ApplicationController
  skip_before_action :login_required, :only => [:create, :new]
  
  def new
    @player = Player.new
  end

  def create
    @player = Player.find_by_name(params[:session][:name])
    if @player && @player.authenticate(params[:session][:password])
      login(@player)
      #session[:player_id] = @player.id
      redirect_to @player, :notice => "Hello, #{@player.name}"
    else
      if !@player
        flash.now[:notice] = "Incorrect name"
      elsif !@player.authenticate(params[:session][:password])
        flash.now[:notice] = "Wrong password"
      else
        flash.now[:notice] = "Login failed"
      end
      render "new"
    end
  end

  def destroy
    session[:player_id] = nil
    session[:admin] = nil
    redirect_to root_path
  end
  
  private
    def login(player)
      session[:player_id] = player.id
      if @player.admin
        session[:admin] = true
      end
    end

end
