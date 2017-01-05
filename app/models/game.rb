class Game < ApplicationRecord
  belongs_to :player
  
  validates :name, 
        :presence => {:message => " was not entered" },
        :length => { :within => 2..40, :message => " must be between 2 and 40 characters"}
  
  validates :player, 
        :presence => {:message => " not linked to a player id" }
        
  #validate :checkNameUnique
  validate :playerGameCap
 
  #def checkNameUnique
  #    @found = false
  #      if player == nil
  #          return
  #      end
  #      player.games.each do |g|
  #          if (g.name == name)
  #              @found = true
  #              errors.add(:name, "That name is already used by another game")
  #              return
  #          end
  #      end
  #      if @found
  #           errors.add(:name, "That name is already used by another game")
  #      end
  #end
 
 def playerGameCap
     if player == nil
            return
     end
     if (player.games.count>4)
         errors.add(:player, "That player cannot add any more games")
     end
 end
        
end
