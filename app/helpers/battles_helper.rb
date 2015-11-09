module BattlesHelper

  def player_started?(battle)
  	is_player_1?(battle) ? player_1_start : player_2_start
  end

  def start_battle(battle)
  	if is_player_1?(battle)
  		battle.update_attribute(:player_1_start, true)
  	else
  		battle.update_attribute(:player_2_start, true)
  	end
  	@player_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
  end

  def save_answers(battle)
  	if is_player_1?(battle)
  		battle.update_attribute(:player_1_answers, @player_answers)
    else
      battle.update_attribute(:player_2_answers, @player_answers)
    end
  end

  def is_player_1?(battle)
  	current_user == battle.player_1
  end

end