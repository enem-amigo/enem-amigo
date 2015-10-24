require 'test_helper'
class MedalsHelperTest < ActionView::TestCase

  def setup
    @user = users(:renata)
    @first_medal = medals(:first_medal)
    @second_medal = medals(:second_medal)
  end

  test "check_medals should return missing medals recently achieved" do
    log_in @user

    check_medals
    assert @new_medals.first.name == @first_medal.name

    current_user.update_attribute(:accepted_questions, [1, 2, 3, 4, 5])
    check_medals
    assert @new_medals.first.name == @second_medal.name
  end

  test "achieved should return true if user got the medal" do
    log_in @user
    assert achieved(@first_medal)
  end

  test "achieved should return false if user did not get the medal " do
    log_in @user
    assert_not achieved(@second_medal)
  end

  test "message should return instructions to get the missing medal" do
    @user.update_attribute(:accepted_questions, [1, 2])
    log_in @user
    assert "Faltam 3 questões" == message(@second_medal)
  end
end