module BattlesHelper

  def player_started?(battle)
    is_player_1?(battle) ? battle.player_1_start : battle.player_2_start
  end

  def start_battle(battle)
  	if is_player_1?(battle)
  		battle.player_1_start = true
      battle.player_1_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
      battle.player_1_time = Time.now.to_i
      battle.save
  	else
  		battle.player_2_start = true
      battle.player_2_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
      battle.player_2_time = Time.now.to_i
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

  def process_result
    @battle = Battle.find(params[:id])

    count_questions
    player_1 = @battle.player_1
    player_2 = @battle.player_2

    player_1.update_attribute(:battle_points, player_1.battle_points + @player_1_points)
    player_2.update_attribute(:battle_points, player_2.battle_points + @player_2_points)

    if @player_1_points > @player_2_points
      @battle.update_attribute(:winner, player_1)
      player_1.update_attribute(:wins, player_1.wins + 1)
    elsif @player_1_points < @player_2_points
      @battle.update_attribute(:winner, player_2)
      player_2.update_attribute(:wins, player_2.wins + 1)
    elsif @battle.player_1_time > @battle.player_2_time
      @battle.update_attribute(:winner, player_1)
      player_1.update_attribute(:wins, player_1.wins + 1)
    else
      @battle.update_attribute(:winner, player_2)
      player_2.update_attribute(:wins, player_2.wins + 1)
    end

    @battle.update_attribute(:processed, true)
  end

  def verify_processed
    @battle = Battle.find(params[:id])
    if @battle.processed
      flash[:danger] = "Você já participou dessa batalha, espere o outro jogador"
      redirect_to battles_path
    end
  end

  def verify_participation
    @battle = Battle.find(params[:id])

    unless player_started?(@battle)
      start_battle(@battle)
    else
      flash[:danger] = "Você já participou desta batalha"
      redirect_to battles_path
    end
  end

  def verify_played
    @battle = Battle.find(params[:id])

    if @battle.player_1_start and @battle.player_2_start
      flash[:danger] = "A batalha ainda não foi finalizada"
      redirect_to battles_path
    end
  end

  def count_questions
    player_1_comparison = @battle.questions.zip(@battle.player_1_answers).map { |x, y| x.right_answer == y }
    player_2_comparison = @battle.questions.zip(@battle.player_2_answers).map { |x, y| x.right_answer == y }
    player_1_comparison.delete(false)
    player_2_comparison.delete(false)

    @player_1_points = player_1_comparison.count
    @player_2_points = player_2_comparison.count
  end

  def process_time(battle)
    if is_player_1?(battle)
      battle.update_attribute(:player_1_time, Time.now.to_i - battle.player_1_time)
    else
      battle.update_attribute(:player_2_time, Time.now.to_i - battle.player_2_time)
    end
  end

end