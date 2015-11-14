class BattleTest < ActiveSupport::TestCase

  def setup
    @user = users(:renata)
  end

  test "should be valid" do
    create_battle
    assert @battle.valid?
  end


  test "player_2 should not be nil" do
    create_battle
    @battle.player_2 = nil
    assert_not @battle.valid?
  end

  test "all_played should return false if one of the 2 players did not played yet" do
    create_battle
    @battle.player_1_start = true
    assert_not @battle.all_played?
  end

  test "all_played should return true if the 2 players already played" do
    create_battle
    @battle.player_1_start = true
    @battle.player_2_start = true
    assert @battle.all_played?
  end

  test "generate_questions should generate array of 10 random questions if battle do not have a category" do
    create_battle
    @battle.category = ""
    @battle.generate_questions
    assert_equal @battle.questions.to_a.count, 10
  end

  test "generate_questions should generate array of 10 random questions of specified category if battle have a category" do
    create_battle
    @battle.category = "matemática e suas tecnologias"
    @battle.generate_questions
    areas = []
    @battle.questions.each do |x|
      areas.push(x.area)
    end
    assert @battle.questions.to_a.count == 10 and areas.uniq.count == 1
  end

  private

    def create_battle
      @battle = Battle.new(player_2: @user)
    end

end