require 'test_helper'
include SessionsHelper

class BattlesControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @battle = battles(:first_battle)
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
    post :create, battle: {category: " "}, player_2_nickname: @another_user.nickname
    assert_equal battle_number+1, Battle.all.count
  end

  test 'should not get create battle if player 2 nickname is invalid' do
    log_in @user
    battle_number = Battle.all.count
    post :create, battle: {category: " "}, player_2_nickname: 'wrong_user'
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

  test 'should answer battle' do
    @battle.player_1_answers = ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
    post :answer, id: @battle.id, alternative: 'o'
    assert_equal @battle.player_1_answers, ['.', '.', '.', '.', '.', '.', '.', '.', '.', '.']
  end

end