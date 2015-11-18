require 'test_helper'

include SessionsHelper
include BattlesHelper

class BattlesControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @battle = battles(:first_battle)
    @battle.generate_questions
    @battle.update_attributes(player_1: @user, player_2: @another_user)
    log_in @user
  end

  test 'should get new battle if user is logged in' do
    get :new
    assert_response :success
  end

  test 'should not get new battle if user is not logged in' do
    log_out
    get :new
    assert_response :redirect
  end

  test 'should get create battle if player 2 nickname is valid' do
    battle_number = Battle.all.count
    Question.any_instance.stubs(:valid?).returns(true)
    post :create, battle: {category: ""}, player_2_nickname: @another_user.nickname
    assert_equal battle_number+1, Battle.all.count
  end

  test 'should not get create battle if player 2 nickname is invalid' do
    battle_number = Battle.all.count
    Question.any_instance.stubs(:valid?).returns(true)
    post :create, battle: {category: ""}, player_2_nickname: 'wrong_user'
    assert_equal battle_number, Battle.all.count
  end

  test 'player 1 should get show of a battle if user did not played the battle yet' do
    get :show, id: @battle.id
    assert_response :success
  end

  test 'player 2 should get show of a battle if user did not played the battle yet' do
    log_out
    log_in @another_user
    get :show, id: @battle.id
    assert_response :success
  end

  test 'should not get show of a battle if user played the battle' do
    @battle.update_attribute(:player_1_start, true)
    get :show, id: @battle.id
    assert_response :redirect
    assert_redirected_to(controller: "battles")
  end

  test 'should get index of battles if user is logged in' do
    get :index
    assert_response :success
  end

  test 'should get index of battles if user is not logged in' do
    log_out
    get :index
    assert_response :redirect
  end

  test 'should get destroy if user is logged in' do
    battles_number = Battle.all.count
    delete :destroy, id: @battle.id
    assert_equal battles_number-1, Battle.all.count
  end

  test 'should get ranking if user is logged in' do
    get :ranking
    assert_response :success
  end

  test 'player 1 should answer question in a battle' do
    @battle.update_attribute(:player_1_answers, ['a', '.', '.', '.', '.', '.', '.', '.', '.', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'b'
    @battle.reload
    assert_equal @battle.player_1_answers, ['a', 'b', '.', '.', '.', '.', '.', '.', '.', '.']
  end

  test 'player 2 should answer question in a battle' do
    log_out
    log_in @another_user
    @battle.update_attribute(:player_2_answers, ['a', 'd', 'c', '.', '.', '.', '.', '.', '.', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'a'
    @battle.reload
    assert_equal @battle.player_2_answers, ['a', 'd', 'c', 'a', '.', '.', '.', '.', '.', '.']
  end

  test 'player 1 should finish the battle if the user answers the last question of battle' do
    @battle.update_attribute(:player_1_answers, ['a', 'd', 'c', 'e', 'e', 'c', 'a', 'c', 'b', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'c'
    assert flash[:success], "Batalha finalizada com sucesso!"
  end

  test 'player 2 should finish the battle if the user answers the last question of battle' do
    log_out
    log_in @another_user
    @battle.update_attribute(:player_2_answers, ['a', 'd', 'c', 'e', 'e', 'c', 'a', 'c', 'b', '.'])
    post :answer, format: 'js', id: @battle.id, alternative: 'c'
    assert flash[:success], "Batalha finalizada com sucesso!"
  end

  test 'player should not get finish if did not played the battle yet' do
    get :finish, id: @battle.id
    assert_redirected_to battles_path
  end

  test 'player should get finish if already played the battle' do
    @battle.update_attribute(:player_1_start, true)
    get :finish, id: @battle.id
    assert_response :success
  end

  test 'player 1 should not get result if one of the players did not played yet' do
    @battle.update_attributes(player_1_start: true)
    get :result, id: @battle.id
    assert_redirected_to battles_path
  end

  test 'player 1 should get result if both already played' do
    @battle.update_attributes(player_1_start: true, player_2_start: true)
    get :result, id: @battle.id
    assert_response :success
  end

  test 'player 2 should get result if both already played and battle was previously processed' do
    log_out
    log_in @another_user
    @battle.update_attributes(player_1_start: true, player_2_start: true, player_1_answers: ['a', 'c', 'c', 'a', 'e', 'a', 'a', 'a', 'a', 'd'], player_1_time: 100, player_2_time: 100)
    get :result, id: @battle.id
    get :result, id: @battle.id
    assert_response :success
  end

  test 'should generate random user' do
    get :generate_random_user
    assert_response :success
  end

end