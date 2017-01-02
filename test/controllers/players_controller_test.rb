require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  
  test "should redirect from show player to login when not logged in" do
    get player_path(:id => 1)
    assert_redirected_to login_url
  end
  
  test "show page success" do
    login(1)
    get player_path(:id => 1)
    assert_response :success
  end

  test "don't show page for nonexistant user" do
    login(1)
    get player_path(:id => 3)
    assert_redirected_to player_path(:id => 1)
  end
  
  test "should make a new player if the params are valid" do
    assert_difference('Player.count', +1) do
      post players_path, params: { player: { name: "newName", password: "newPass", password_confirmation: "newPass", admin: true } }
    end
    assert_response :redirect
  end
  
  test "should not make a new player if the params are invalid" do
    assert_no_difference('Player.count') do #username already taken
      post players_path, params: { player: { name: "testerAdmin", password: "newPass", password_confirmation: "newPass", admin: true } }
    end
    assert_template "new"
    assert_no_difference('Player.count') do #bad username
      post players_path, params: { player: { name: "x", password: "newPass", password_confirmation: "newPass", admin: true } }
    end
    assert_template "new"
    assert_no_difference('Player.count') do #bad password
      post players_path, params: { player: { name: "newName", password: "x", password_confirmation: "x", admin: true } }
    end
    assert_template "new"
    assert_no_difference('Player.count') do #bad username and password
      post players_path, params: { player: { name: "x", password: "x", password_confirmation: "x", admin: true } }
    end
    assert_template "new"
    assert_no_difference('Player.count') do #password and confirmation don't match
      post players_path, params: { player: { name: "newName", password: "newPass", password_confirmation: "newPassX", admin: true } }
    end
    assert_template "new"
  end

  test "should destroy a player when an admin tries it on another player" do
    login(1)
    assert_difference('Player.count', -1) do
      delete player_path(players(:two))
    end
    assert_redirected_to players_path
  end
    
  test "should't destroy when it's done wrong" do
    
    #not logged in
    assert_no_difference('Player.count') do
      delete player_path(players(:two))
    end
    assert_redirected_to login_url
    
    #logged in as regular user
    login(2)
    assert_no_difference('Player.count') do
      delete player_path(players(:one))
    end
    assert_redirected_to player_path(:id => players(:two).id)
    
    #self deletion
    get logout_path
    login(1)
    assert_no_difference('Player.count') do
      delete player_path(players(:one))
    end
    assert_redirected_to players_path
    
    #no player with that ID
    assert_no_difference('Player.count') do
      delete player_path(:id => 3)
    end
    assert_redirected_to players_path
  end
    
  test "should show index when an admin tries to access it" do
    login(1)
    get players_url
    assert_response :success
  end

  test "should not show player index when not allowed" do
    #not signed in
    get players_url
    assert_redirected_to login_url
    
    #signed in as regular user
    login(2)
    get players_url
    assert_redirected_to player_path(:id => players(:two).id)
    
  end
  
  #editing, once I put it in
end