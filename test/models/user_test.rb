require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Artemis", email: "huntress@olympus.mt", password: "goddessdiana", password_confirmation: "goddessdiana")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name present" do
  	@user.name = "  "
  	assert_not @user.valid?
  end

  test "email present" do
  	@user.email = " "
  	assert_not @user.valid?
  end

  test "name too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email too long" do
  	@user.email = "a" * 244 +  "@example.com"
  	assert_not @user.valid?
  end

  test "accept valid emails" do
  	valid = %w[hello@example.com huntress@mt.olympus.org lem.singer@worldbuilder.sff LIFT_shardfork@roshar.wd]
  	valid.each do |address|
  		@user.email = address
  		assert @user.valid?, "#{address.inspect} should be valid"
  	end
  end

  test "reject invalid emails" do
  	invalid = %w[goaway@this,iswrong blah_blah_blah.org jean.valjean@lesmis. meow@grumpy_cat.com boo@x+y.com]
  	invalid.each do |address|
  		@user.email = address
  		assert_not @user.valid? "#{address.inspect} should be invalid"
  	end
  end

  test "unique email address" do
  	duplicate = @user.dup
  	duplicate.email = @user.email.upcase
  	@user.save
  	assert_not duplicate.valid?
  end

  test "password nonblank" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password mininum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

  test "authenticated?" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "destroy associated microposts" do
    @user.save
    @user.microposts.create!(content: "I am a cat")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

end
