module SessionsHelper
    def log_in(player)
        session[:player_id] = player.id
    end
end
