require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:michael)
  	@micropost = @user.microposts.build(content: "Kitty ipsum")
  end

  test "should be valid" do
  	assert @micropost.valid?
  end

  test "user id present" do
  	@micropost.user_id = nil
  	assert_not @micropost.valid?
  end

  test "content present" do
  	@micropost.content = ""
  	assert_not @micropost.valid?
  end

  test "content less than 140 char" do
  	@micropost.content = "a" * 141
  	assert_not @micropost.valid?
  end

  test "order" do
  	assert_equal microposts(:most_recent), Micropost.first
  end

end
