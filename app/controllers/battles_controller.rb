class BattlesController < ApplicationController

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(player_1: current_user, player_2: User.where(nickname: :player_2_nickname))

    if @battle.save
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
    @battle.destroy
    redirect_to battles_path
  end

  private
    def battle_params
      params.permit(:player_2_nickname)
    end

end
