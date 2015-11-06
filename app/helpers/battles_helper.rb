module BattlesHelper

  def generate_questions(battle)
    battle.questions = battle.category == "" ? Question.all.sample(10) : Question.where(area: battle.category).sample(10)
    battle.save
  end

end