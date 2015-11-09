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

end
