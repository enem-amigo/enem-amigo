

class MedalTest < ActiveSupport::TestCase

  test "should be valid" do
    create_medal
    assert @medal.valid?
  end

  test "name should not be blank" do
    create_medal
    @medal.name = ""
    assert_not @medal.valid?
  end

  test "description should not be blank" do
    create_medal
    @medal.description = ""
    assert_not @medal.valid?
  end

  test "achieved_instructions should not be blank" do
    create_medal
    @medal.achieved_instructions = []
    assert_not @medal.valid?
  end

  test "achieved_instructions should not be invalid intructions" do
    create_medal
    @medal.achieved_instructions = ["wrong"]
    assert_not @medal.valid?
  end

  test "achieved_instructions should not change current_user" do
    create_medal
    @medal.achieved_instructions = ["current_user.name = 'RENATA'", "return true"]
    assert_not @medal.valid?
  end

  test "achieved_instructions should not return other than true or false" do
    create_medal
    @medal.achieved_instructions = ["return 'String'"]
    assert_not @medal.valid?
  end

  test "message_instructions should not be blank" do
    create_medal
    @medal.message_instructions = []
    assert_not @medal.valid?
  end

  test "message_instructions should not be invalid intructions" do
    create_medal
    @medal.message_instructions = ["wrong"]
    assert_not @medal.valid?
  end

  test "message_instructions should not return other than String" do
    create_medal
    @medal.message_instructions = ["return 1+1"]
    assert_not @medal.valid?
  end

  test "message_instructions should not change current_user" do
    create_medal
    @medal.message_instructions = ["current_user.name = 'RENATA'", "return 'String'"]
    assert_not @medal.valid?
  end

  private

    def create_medal
      @medal = Medal.new(name: "Medalha", description: "Descrição aqui", image: "trophy.png", achieved_instructions: ["return true"], message_instructions: ["return ''"])
    end

end