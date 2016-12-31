require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "create: should sign in with correct credentials" do
    player_to_log_in = players(:one)
    post login_url, params: { session: { name: "testerAdmin", password: "password1" } }
    assert_not_nil session[:player_id]
    assert_equal player_to_log_in.id, session[:player_id]
  end
  
  test "create: should not sign in with incorrect credentials" do
    post login_url, params: { session: { name: "totallyFakeName", password: "NotRightEither" } }
    assert_nil session[:player_id]
  end
  
  test "create: should sign in as the correct user" do
    player_to_log_in = players(:one)
    post login_url, params: { session: { name: "testerAdmin", password: "password1" } }
    assert_equal player_to_log_in.id, session[:player_id]
  end

  test "logs out session" do
    get logout_path
    assert_nil session[:player_id]
    assert_nil session[:admin]
    assert_redirected_to login_url
  end

end
