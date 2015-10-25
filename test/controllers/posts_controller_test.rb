require 'test_helper'
include SessionsHelper

class PostsControllerTest < ActionController::TestCase

	def setup
		@user= users(:joao)
		@topic= Topic.create(name: 'Questão 1', question_id: 1, description: 'Dúvidas e respostas', post_at: DateTime.now)
	end

	test 'should get create post' do
		log_in @user
		post :create, post: {content: 'Isso é um teste', topic_id: @topic.id, user_id: 1}
		assert_response :redirect
	end

end