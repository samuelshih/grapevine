require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    # @user = User.new(name: 'Example Name', email: 'email@example.com', password: 'password', password_confirmation: 'password')
    @user = users(:login_test) # Use fixture instead
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid?, "#{valid_addresses.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, " #{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '') # Token value doesn't matter b/c should error before it ever gets used
  end

  # WIP Broken test
  # test 'associated posts should be destroyed' do
  #   @user.save
  #   @user.posts.create!(content: 'Lorem ipsum') # build does not modify the database
  #   assert_difference 'Post.count', -1 do
  #     @user.destroy
  #   end
  # end

  test 'should follow and unfollow a user' do
    login_test = users(:login_test)
    archer = users(:archer)
    assert_not login_test.following?(archer)
    login_test.follow(archer)
    assert login_test.following?(archer)
    assert archer.followers.include?(login_test)

    login_test.unfollow(archer)
    assert_not login_test.following?(archer)
  end
end
