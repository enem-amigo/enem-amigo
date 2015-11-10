module BattlesHelper

  def player_started?(battle)
    is_player_1?(battle) ? battle.player_1_start : battle.player_2_start
  end

  def start_battle(battle)
  	if is_player_1?(battle)
  		#battle.player_1_start = true
      battle.player_1_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
      battle.save
  	else
  		#battle.player_2_start = true
      battle.player_2_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
      battle.save
  	end
  end

  def save_answers(battle)
  	battle.save
  end

  def is_player_1?(battle)
  	current_user == battle.player_1
  end

  def is_last_question?
    session[:counter] == 10
  end

end