require 'test_helper'

include SessionsHelper
include BattlesHelper

class BattlesControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @battle = battles(:first_battle)
    generate_alternatives
    @battle.generate_questions
    @battle.update_attributes(player_1: @user, player_2: @another_user)
  end

  test 'should get new battle if user is logged in' do
    log_in @user
    get :new
    assert_response :success
  end

  test 'should not get new battle if user is not logged in' do
    log_in @user
    log_out
    get :new
    assert_response :redirect
  end

  test 'should get create battle if player 2 nickname is valid' do
    log_in @user
    battle_number = Battle.all.count
    Question.any_instance.stubs(:valid?).returns(true)
    post :create, battle: {category: ""}, player_2_nickname: @another_user.nickname
    assert_equal battle_number+1, Battle.all.count
  end

  test 'should not get create battle if player 2 nickname is invalid' do
    log_in @user
    battle_number = Battle.all.count
    Question.any_instance.stubs(:valid?).returns(true)
    post :create, battle: {category: ""}, player_2_nickname: 'wrong_user'
    assert_equal battle_number, Battle.all.count
  end

  test 'should get show of a battle if user did not played the battle yet' do
    log_in @user
    get :show, id: @battle.id
    assert_response :success
  end

  test 'should not get show of a battle if user played the battle' do
    log_in @user
    @battle.update_attribute(:player_1_start, true)
    get :show, id: @battle.id
    assert_response :redirect
    assert_redirected_to(controller: "battles")
  end

  test 'should get index of battles if user is logged in' do
    log_in @user
    get :index
    assert_response :success
  end

  test 'should get index of battles if user is not logged in' do
    log_in @user
    log_out
    get :index
    assert_response :redirect
  end

  test 'should get destroy if user is logged in' do
    log_in @user
    battles_number = Battle.all.count
    delete :destroy, id: @battle.id
    assert_equal battles_number-1, Battle.all.count
  end

  test 'should get ranking if user is logged in' do
    log_in @user
    get :ranking
    assert_response :success
  end

  test 'player 1 should answer question in a battle' do
    log_in @user
    @battle.update_attribute(:player_1_answers, ['a', '.', '.', '.', '.', '.', '.', '.', '.', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'b'
    @battle.reload
    assert_equal @battle.player_1_answers, ['a', 'b', '.', '.', '.', '.', '.', '.', '.', '.']
  end

  test 'player 2 should answer question in a battle' do
    log_in @another_user
    @battle.update_attribute(:player_2_answers, ['a', 'd', 'c', '.', '.', '.', '.', '.', '.', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'a'
    @battle.reload
    assert_equal @battle.player_2_answers, ['a', 'd', 'c', 'a', '.', '.', '.', '.', '.', '.']
  end

  test 'should finish the battle if the user answers the last question of battle' do
    log_in @user
    @battle.update_attribute(:player_1_answers, ['a', 'd', 'c', 'e', 'e', 'c', 'a', 'c', 'b', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'c'
    assert flash[:success], "Batalha finalizada com sucesso!"
  end

  private

  def generate_alternatives
    Question.all.each do |question|
    unless question.valid?
      5.times{question.alternatives.build}
        question.alternatives.each do |a|
          a.letter = 'a'
          a.description = 'something'
        end
        question.save
      end
    end
  end

end