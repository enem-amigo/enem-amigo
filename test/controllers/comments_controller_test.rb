require 'test_helper'
include SessionsHelper

class CommentsControllerTest < ActionController::TestCase
	
	def setup
		@user= users(:joao)
		@topic= Topic.create(name: 'Test1', question_id: 1, description: 'Test', post_at: DateTime.now)
		@post = Post.create(content: 'Controller', topic_id: @topic.id, user_id: @user.id)
	end

	test 'should create a comment' do
		@comment = Comment.create(content: 'Teste', post_id: @post.id, user_id: @user.id)
		assert_response :success
	end
	
end