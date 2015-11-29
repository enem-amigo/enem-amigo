class BattlesController < ApplicationController

  include BattlesHelper

  before_action :authenticate_user
  before_action :verify_participation, only: [:show, :destroy]
  before_action :verify_all_played, only: [:result]
  before_action :verify_current_user_played, only: [:finish]

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(player_1: current_user, player_2: User.where(nickname: params[:player_2_nickname]).first)
    @battle.category = params[:battle][:category]
    @battle.generate_questions
    if @battle.save
      new_battle_notification(@battle)

      flash[:success] = "Convite enviado com sucesso!"
      redirect_to battles_path
    else
      flash[:danger] = "Usuário não encontrado"
      render 'new'
    end
  end

  def show
    @battle = Battle.find(params[:id])
    start_battle(@battle)
    battle_answer_notification(@battle, true) unless is_player_1?(@battle)
    @question = @battle.questions[0]
  end

  def index
    @battles = current_user.battles.reverse
  end

  def destroy
    @battle = Battle.find(params[:id])
    battle_answer_notification(@battle, false)
    @battle.destroy
    redirect_to battles_path
  end

  def ranking
    @users = User.order(:wins, :battle_points).reverse
  end

  def answer
    battle = Battle.find(params[:id])

    question_position = question_number(battle)

    question = battle.questions[question_position]
    @answer_letter = params[:alternative]

    unless params[:alternative].blank?
      question.update_attribute(:users_tries, question.users_tries + 1)

      @correct_answer = (@answer_letter == question.right_answer)
      question.update_attribute(:users_hits, question.users_hits + 1) if @correct_answer
      if is_player_1?(battle)
        battle.player_1_answers[question_position] = @answer_letter
      else
        battle.player_2_answers[question_position] = @answer_letter
      end
      question_position = question_position.succ
      battle.save
    end

    if question_position == battle.questions.count
      process_time(battle)
      flash[:success] = "Batalha finalizada com sucesso!"
      render :js => "window.location.href += '/finish'"
    else
      @question = battle.questions[question_position]
    end
  end

  def finish
    @battle = Battle.find(params[:id])
    player_answers = is_player_1?(@battle) ? @battle.player_1_answers : @battle.player_2_answers
    @answers = @battle.questions.zip(player_answers)
    player_comparison = @answers.map { |x, y| x.right_answer == y }
    player_comparison.delete(false)

    @player_points = player_comparison.count
  end

  def result
    @battle = Battle.find(params[:id])

    if @battle.processed?
      count_questions
    else
      process_result
    end

    @battle.reload
    if is_player_1?(@battle)
      current_player_answers = @battle.player_1_answers
      adversary_answers = @battle.player_2_answers
      @current_player_stats = [@player_1_points, @battle.player_1_time]
      @adversary_stats = [@player_2_points, @battle.player_2_time]
    else
      current_player_answers = @battle.player_2_answers
      adversary_answers = @battle.player_1_answers
      @current_player_stats = [@player_2_points, @battle.player_2_time]
      @adversary_stats = [@player_1_points, @battle.player_1_time]
    end

    @current_player_stats[1] = @current_player_stats.second >= 610 ? "--:--" : "#{@current_player_stats.second/60}:#{@current_player_stats.second%60 < 10 ? "0" : ""}#{@current_player_stats.second%60}"
    @adversary_stats[1] = @adversary_stats.second >= 610 ? "--:--" : "#{@adversary_stats.second/60}:#{@adversary_stats.second%60 < 10 ? "0" : ""}#{@adversary_stats.second%60}"
    @answers = @battle.questions.zip(current_player_answers, adversary_answers)
  end

  def generate_random_user
    random_user = (User.all - [current_user]).sample

    render :text => random_user.nickname
  end
end