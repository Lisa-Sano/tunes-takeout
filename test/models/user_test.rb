require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    # @known = { "provider" => 'spotify', "info" => { "id" => "known_user", "name" => "known user", "image" => "image"} }
    @known = OmniAuth.config.mock_auth[:spotify_known]
    @unknown = OmniAuth.config.mock_auth[:spotify_unknown]
    # @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "can make a new user given the oauth spotify hash of an unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "uses oauth data to set user name, provider, image and uid for new users" do
    user = User.find_or_create_from_omniauth @unknown

    assert_equal @unknown['info']['name'], user.name
    assert_equal @unknown['provider'], user.provider
    assert_equal @unknown['uid'], user.uid
    assert_equal @unknown['info']['image'], user.image
  end

  # test "prefers a top-level uid over a nested id when creating an oauth user" do
  #   user = User.find_or_create_from_omniauth @unknown_with_uid
  #   assert_equal @unknown_with_uid['uid'], user.uid
  # end
end
