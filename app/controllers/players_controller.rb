class PlayersController < ApplicationController
    skip_before_action :login_required, :only => [:new, :create]
    
    def new
       @player = Player.new 
    end
    
    def show
        @player = Player.find(params[:id])
    end
    
    def index
        if !session[:admin]
            redirect_to player_path(:id => session[:player_id]), notice: 'Only admins can go there.'
        end
  	    @players = Player.all
    end
    
    def create
        
        if player_params[:password] != player_params[:password_confirmation]
            flash[:notice] = "Password and confirmation do not match!"
            redirect_to new_player_path 
        end
        
        @player = Player.new(player_params)
        if @player.save
  		    flash[:notice] = "Signup successful"
  		    params[:player] = {:id=> @player.id}
  		    session[:player_id] = @player.id
            if @player.admin
                session[:admin] = true;
                redirect_to player_path(:id => @player.id)
            else
                redirect_to player_path(:id => @player.id)
            end
  	    else
  		    flash[:notice] = "Error with your signup"
  		    render :new
        end
    end
    
    ####
    #### Add an admin check for this
    ####
    def destroy
        if !session[:admin]
            redirect_to players_url, notice: 'Only admins can do that.'
        end
        @player = Player.find(params[:id])
        #if params[:id] == session[:player_id]
        if @player.id == session[:player_id]
            redirect_to players_url, notice: 'You cannot delete your own profile.'
        else
            @player.destroy
            redirect_to players_url, notice: 'Profile was successfully destroyed.'
        end
    end
    
    def player_params
        params.require(:player).permit(:name, :password, :password_confirmation, :id, :admin)
    end
    
end
