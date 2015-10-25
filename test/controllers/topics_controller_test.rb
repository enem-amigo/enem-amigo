require 'test_helper'
include SessionsHelper

class TopicsControllerTest < ActionController::TestCase

	def setup
		@user= users(:joao)
		@admin= users(:admin)
		@topic= Topic.create(name: 'Questão 1', question_id: 1, description: 'Dúvidas e respostas', post_at: DateTime.now)
	end
	
	test 'should get create topic' do 
		log_in @admin
		post :create, topic: {name: 'Questão 1 - Prova 2010', question_id: 1, description: 'Dúvidas e respostas sobre quesão 1 da prova de 2010', post_at: DateTime.now}
		assert_equal Topic.last.name, 'Questão 1 - Prova 2010'
	end

	test 'should get topic show' do
		log_in @user
		get :show, id: @topic.id
		assert_response :success
	end

	test 'should get topic index' do
		log_in @user
		get :index
		assert_response :success
	end

end