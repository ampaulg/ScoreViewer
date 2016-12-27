class Player < ApplicationRecord
    has_secure_password

    validates :name, 
        :presence => {:message => "You need to enter a name" },
        :uniqueness => {:message => "That name is already being used."},
        :length => { :within => 2..20, :message => "Name must be between 2 and 20 characters"}
    
    validates :password,
        :presence => {:message => "You need to enter a password" },
        :length => { :within => 6..20, :message => "Password must be between 6 and 20 characters"}

end
