class BattlesController < ApplicationController

  include BattlesHelper

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(player_1: current_user, player_2: User.where(nickname: params[:player_2_nickname]))
    generate_questions(@battle)   
    if @battle.save
      new_battle_notification(@battle)
      flash[:success] = "Convite enviado com sucesso!"
    else
      render 'new'
    end
  end

  def show
    @battle = Battle.find(params[:id])
    
    unless player_started?(@battle)
      start_battle(@battle)
    else
      flash[:danger] = "Você já participou desta batalha"
      redirect_to battles_path
    end
  end    

  def index
    @battles = current_user.battles
  end

  def destroy
    @battle = Battle.find(params[:id])
    battle_answer_notification(@battle, false)
    @battle.destroy
    redirect_to battles_path
  end

  def finish
    @battle = Battle.find(params[:id])
    save_answers(battle)
    redirect_to battles_path
  end

  def result
    @battle = Battle.find(params[:id])
    player_1_comparison = @battle.questions.zip(player_1_answers).map { |x, y| x.right_answer == y }
    player_2_comparison = @battle.questions.zip(player_2_answers).map { |x, y| x.right_answer == y }
    player_1_comparison.delete(false)
    player_2_comparison.delete(false)

    player_1_points = player_1_comparison.count
    player_2_points = player_2_comparison.count

    player_1.update_attribute(:battle_points, player_1.battle_points + player_1_points)
    player_2.update_attribute(:battle_points, player_2.battle_points + player_2_points)

    if player_1_points > player_2_points
      @battle.update_attribute(:winner, player_1)
      player_1.update_attribute(:wins, player_1.wins + 1)
    elsif player_1_points < player_2_points
      @battle.update_attribute(:winner, player_2)
      player_2.update_attribute(:wins, player_2.wins + 1)
    elsif player_1_time > player_2_time
      @battle.update_attribute(:winner, player_1)
      player_1.update_attribute(:wins, player_1.wins + 1)
    elsif player_1_time < player_2_time
      @battle.update_attribute(:winner, player_2)
      player_2.update_attribute(:wins, player_2.wins + 1)
    end
      
  end
end
