class BattlesController < ApplicationController

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(player_1: current_user, player_2: User.where(nickname: params[:player_2_nickname]))
    if @battle.save
      new_battle_notification(@battle)
      flash[:success] = "Convite enviado com sucesso!"
    else
      render 'new'
    end
  end

  def show
    @battle = Battle.find(params[:id])
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


  def start
    @battle = Battle.find(params[:id])
    @player_answers = []
  end

  def stop
    @battle = Battle.find(params[:id])
    if current_user == @battle.player_1
      @battle.update_attribute(:player_1_answers, @player_answers)
    else
      @battle.update_attribute(:player_2_answers, @player_answers)
    end
    redirect_to @battle
  end

end
