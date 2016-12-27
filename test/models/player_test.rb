require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test "don't save blank player" do
    player = Player.new
    assert_not player.save
  end
  
  test "save player with correct info" do
    player = Player.new
    player.name = "Ayy Lmao"
    player.password = "hoo hah"
    assert player.save
  end
  
  test "don't save player with short name" do
    player = Player.new
    player.name = "A"
    player.password = "hoo hah"
    assert_not player.save
  end
  
  test "don't save player with short password" do
    player = Player.new
    player.name = "Ayy lmao"
    player.password = "hoo h"
    assert_not player.save
  end
  
  test "don't save player with long name" do
    player = Player.new
    player.name = "Ayy lmao9012345678901"
    player.password = "hoo hah"
    assert_not player.save
  end
  
  test "don't save player with long password" do
    player = Player.new
    player.name = "Ayy lmao"
    player.password = "hoo hah89012345678901"
    assert_not player.save
  end
  
end
