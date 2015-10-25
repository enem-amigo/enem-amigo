require 'test_helper'
include SessionsHelper

class MedalsControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
  end

  test 'should get index of medals' do
    log_in @user
    get :index
    assert_response :success
  end

end