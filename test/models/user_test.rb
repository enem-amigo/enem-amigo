class UserTest < ActiveSupport::TestCase

  test 'should be valid' do
    create_user
    assert @user.valid?
  end

  test 'name should not be blank' do
    create_user
    @user.name= ""
    assert_not @user.valid?
  end

  test 'name should not have more than 60 character' do
    create_user
    @user.name= "*"*65
    assert_not @user.valid?
  end

  test 'nickname should not have more than 40 character' do
    create_user
    @user.nickname="*"*45
    assert_not @user.valid?
  end

  test 'nickname should be unique' do
    create_user
    @otheruser= User.new(name: "Example Name Of User", nickname: "examplinho", email: "example2@example2.com", level: "7", password: "supertesttest", password_confirmation: "supertesttest")
    assert_not @otheruser.valid?
  end

  test 'email should not be blank' do
    create_user
    @user.email=""
    assert_not @user.valid?
  end

  test 'email should not have more than 255 character' do
    create_user
    @user.email="*"*256
    assert_not @user.valid?
  end

  test 'email should have valid format' do
    create_user
    @user.email="thisisnotvalid"
    assert_not @user.valid?
  end

  test 'email should be unique' do
    create_user
    @otheruser = User.new(name: "Example Name Of User", nickname: "examplinho", email: "example@example.com", level: "7", password: "supertesttest", password_confirmation: "supertesttest")
    @otheruser.email="example@example.com"
    assert_not @otheruser.valid?
  end

  test 'case sensitive should be false' do
    create_user
    @otheruser = User.new(name: "Example Name Of User", nickname: "examplinho", email: "exaMple@example.com", level: "7", password: "supertesttest", password_confirmation: "supertesttest")
    assert_not @otheruser.valid?
  end

  test 'password should have at least 8 characters' do
    create_user
    @user.password="this"
    assert_not @user.valid?
  end

  private
  def create_user
    @user = User.new(name: "Example Name", nickname: "examplinho", email: "example@example.com", level: "0", password: "supertest", password_confirmation: "supertest");
    @user.save
  end
end

