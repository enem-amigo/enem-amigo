class UserTest < ActiveSupport::TestCase

  def setup
    @math_question = questions(:question_01)
    @humans_question = questions(:question_11)
  end

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

  test "should count_questions_by_area return the number of questions of a specific area" do
    create_user
    @user.accepted_questions.push(@math_question.id)
    @user.accepted_questions.push(@humans_question.id)
    assert_not_equal @user.count_questions_by_area("matemática e suas tecnologias"), 0
    assert_not_equal @user.count_questions_by_area("ciências humanas e suas tecnologias"), 0
    assert_equal @user.count_questions_by_area("linguagens, códigos e suas tecnologias"), 0
  end

  test "should user.data return hash containing name and number of accepted questions for each area" do
    create_user
    data = @user.data
    assert_not data.empty?
    areas = ["Matemática","Natureza","Linguagens","Humanas"]
    data.each do |name,number|
      assert areas.include? name
      assert number >= 0
    end
  end

  private
  def create_user
    @user = User.new(name: "Example Name", nickname: "examplinho", email: "example@example.com", level: "0", password: "supertest", password_confirmation: "supertest");
    @user.save
  end
end

