require 'test_helper'
include SessionsHelper

class CommentsControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @admin = users(:admin)
    @user = users(:renata)
    @user.update_attribute(:id,1)
    @another_user = users(:joao)
    @another_user.update_attribute(:id,2)
    @topic= Topic.create(name: 'Test1', question_id: 1, description: 'Test')
    @post = Post.create(content: 'Controller', topic_id: @topic.id, user_id: @user.id)
    @another_post = Post.create(content: 'Isso é um teste', topic_id: @topic.id, user_id: 2)
    @comment = Comment.create(content: 'TestComment', post_id: @post.id, user_id: 1)
    @another_comment = Comment.create(content: 'TestComment', post_id: @post.id, user_id: 2)
  end

  test "should not get new comment if user is not logged in" do
    get :new
    assert_redirected_to login_path
  end

  test "should get new comment if user is logged in" do
    log_in @user
    get :new
    assert_response :success
  end

  test 'should create a comment' do
    @comment = Comment.create(content: 'Teste', post_id: @post.id, user_id: @user.id)
    assert_response :success
  end

  test 'should another user cannot delete user''s comment' do
    log_in @another_user
    post_parent_id = @comment.post_id
    post_parent = Post.find(post_parent_id)
    topic_parent = post_parent.topic_id
    comment_id = @comment.id
    delete :destroy, id: @comment.id, comment_id: @comment.id
    assert_redirected_to :back
    assert_not_nil Comment.find_by_id(comment_id)
  end

  test 'should user_ratings be incremented if user votes in a comment' do
    log_in @user
    ratings = @comment.user_ratings.count
    post :rate_comment, id: @comment.id, comment_id: @comment.id
    @comment.reload
    assert_equal ratings + 1, @comment.user_ratings.count
  end

  test 'should user_ratings not be incremented if user votes again in a comment' do
    log_in @user
    ratings = @comment.user_ratings.count
    @comment.user_ratings.push(@user.id)
    post :rate_comment, id: @comment.id, comment_id: @comment.id, user_id: @user.id
    @comment.reload
    assert_redirected_to :back
    assert_not_equal ratings + 2, @comment.user_ratings.count
    assert_equal ratings + 1, @comment.user_ratings.count
  end

end