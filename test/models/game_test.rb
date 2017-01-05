require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "don't save game when fields are missing" do
    #neither name or player
    game = Game.new 
    assert_not game.save
    #name only
    game.name = "Street Fighter V"
    assert_not game.save
    #player only
    game.name = nil
    game.player = players(:one)
    assert_not game.save
    
  end
  
  test "save game with correct info" do
    game = Game.new
    game.name = "Street Fighter V"
    game.player = players(:one)
    assert game.save
  end
  
  test "don't save with incorrectly sized name" do
    game = Game.new
    game.name = "1" #too short
    game.player = players(:one)
    assert_not game.save
    game.name = "123456789012345678901234567890123456789012345" #too long
    assert_not game.save
  end
  
  test "don't save multiple games with the same name onto one player" do
    game = Game.new
    game.name = "Street Fighter V"
    game.player = players(:one)
    game.save
    
    game2 = Game.new
    game2.name = "Street Fighter V"
    game2.player = players(:one)
    assert_not game2.save
  end
  
  test "don't save more than 5 games onto one player" do
    game = Game.new
    game.name = "Street Fighter V"
    game.player = players(:one)
    assert game.save
    
    game2 = Game.new
    game2.name = "Street Fighter VI"
    game2.player = players(:one)
    assert game2.save
    
    game3 = Game.new
    game3.name = "Street Fighter VII"
    game3.player = players(:one)
    assert game3.save
    
    game4 = Game.new
    game4.name = "Street Fighter VIII"
    game4.player = players(:one)
    assert game4.save
    
    game5 = Game.new
    game5.name = "Street Fighter IX"
    game5.player = players(:one)
    assert game5.save
    
    game6 = Game.new
    game6.name = "Street Fighter X"
    game6.player = players(:one)
    assert_not game6.save
  end
  
end
