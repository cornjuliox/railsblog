require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:enrico)
  end

  test 'login succeeds with valid creds' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
  end

  test 'login fails with invalid creds' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'notpassword'}}
  end

  test 'logout works' do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?

    delete logout_path
    assert_not is_logged_in?

    assert_redirected_to root_path
    follow_redirect!

    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test 'visiting /login while logged in redirects to home' do 
    post login_path, params: { session: { email: @user.email, password: 'password'}}
    assert is_logged_in?
    get login_path
    assert_redirected_to root_path
  end

end
