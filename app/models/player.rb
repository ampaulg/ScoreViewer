class Player < ApplicationRecord
    has_secure_password

    validates :name, 
        :presence => {:message => " was not entered" },
        :uniqueness => {:message => " is already being used by another player."},
        :length => { :within => 2..20, :message => " must be between 2 and 20 characters"}
    
    validates :password,
        #:presence => {:message => " was not entered" },
        :length => { :within => 6..20, :message => " must be between 6 and 20 characters"}

end
