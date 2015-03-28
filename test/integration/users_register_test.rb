require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  test 'invalid registration' do
    get register_path # post and get technically unnecessary

    assert_no_difference 'User.count' do
      post users_path user: { name: '',
                              email: 'user@invalid',
                              password: 'foo',
                              password_confirmation: 'bar'
                      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid registration' do
    get register_path

    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: 'Billy Bob',
                                            email: 'bob@billy.com',
                                            password: 'super_man_billy',
                                            password_confirmation: 'super_man_billy'
                                  }
    end
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.nil?
  end

end
