class BattlesController < ApplicationController

  include BattlesHelper

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(player_1: current_user, player_2: User.where(nickname: params[:player_2_nickname]))
    @battle.generate_questions
    if @battle.save
      new_battle_notification(@battle)
      flash[:success] = "Convite enviado com sucesso!"
    else
      render 'new'
    end
  end

  def show
    @battle = Battle.find(params[:id])

    session[:counter] = 0
    @question = @battle.questions[0]

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

  def answer
    battle = Battle.find(params[:id])

    question_number = session[:counter]
    session[:counter] = question_number + 1

    question = battle.questions[question_number]
    puts "="*50
    puts question.number
    puts "="*50
    @answer_letter = params[:alternative]

    if params[:alternative].blank?
      session[:counter] = question_number
    else
      question.update_attribute(:users_tries, question.users_tries + 1)

      @correct_answers = (@answer_letter == question.right_answer)
      question.update_attribute(:users_hits, question.users_hits + 1) if @correct_answer
      if is_player_1?(battle)
        battle.player_1_answers[question_number] = @answer_letter
        puts "*"*80
        puts battle.player_1_answers
        puts "*"*80
      else
        battle.player_2_answers[question_number] = @answer_letter
      end
      battle.save
    end

    if is_last_question?
      flash[:success] = "Batalha finalizada com sucesso!"
      render :js => "window.location.href += '/finish'"
    else
      @question = battle.questions[session[:counter]]
    end
  end

  def finish
    @battle = Battle.find(params[:id])
  end
end