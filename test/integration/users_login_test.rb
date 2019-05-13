require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:enrico)
  end

  test 'login with valid info' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert redirected_to @user
  end

end
