ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "bcrypt"
require "test_password_helper"

ActiveRecord::FixtureSet.context_class.send :include, TestPasswordHelper

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include TestPasswordHelper
  
  def login(player)
    if player == 1
      username = players(:one).name
    else
      username = players(:two).name
    end
    post login_url, params: { session: { name: username, password: default_password } }
  end
  
  # Add more helper methods to be used by all tests here...
end
