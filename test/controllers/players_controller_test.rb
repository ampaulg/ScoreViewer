require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @playerA = players(:one)
    @playerR = players(:two)
  end
  
  # test "the truth" do
  #   assert true
  # end
  
  test "should redirect from index to login when not logged in" do
    get players_url
    assert_redirected_to login_url
  end
end
