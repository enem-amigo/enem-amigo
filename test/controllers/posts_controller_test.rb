require 'test_helper'
include SessionsHelper

class PostsControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @user.update_attribute(:id,1)
    @another_user = users(:joao)
    @another_user.update_attribute(:id,2)
    @admin = users(:admin)
    @admin.update_attribute(:id,3)
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @topic= Topic.create(name: 'Questão 1', question_id: 1, description: 'Dúvidas e respostas', post_at: DateTime.now)
    @post = Post.create(content: 'Isso é um teste', topic_id: @topic.id, user_id: 1)
    @another_post = Post.create(content: 'Isso é um teste', topic_id: @topic.id, user_id: 2)
  end

  test 'should redirect to topic when post is deleted' do
    log_in @user
    topic_parent = @post.topic_id
    delete :destroy, id: @post.id
    assert_redirected_to topic_path(topic_parent)
  end

  test 'should user can delete his own post' do
    log_in @user
    topic_parent = @post.topic_id
    delete :destroy, id: @post.id
    assert_redirected_to topic_path(topic_parent)
  end

  test 'should another user cannot delete user''s post' do
    log_in @another_user
    topic_parent = @post.topic_id
    post_id = @post.id
    delete :destroy, id: @post.id
    assert_redirected_to :back
    assert_not_nil Post.find_by_id(post_id)
  end

  test 'should admin can delete any post' do
    log_in @admin
    topic_parent = @post.topic_id
    delete :destroy, id: @post.id
    assert_redirected_to topic_path(topic_parent)
    another_topic_parent = @another_post.topic_id
    delete :destroy, id: @another_post.id
    assert_redirected_to topic_path(another_topic_parent)
  end

  test 'should user_ratings be incremented if user votes in a post' do
    log_in @user
    ratings = @post.user_ratings.count
    post :rate_post, id: @post.id, user_id: @user.id
    @post.reload
    assert_equal ratings + 1, @post.user_ratings.count
  end

  test 'should user_ratings not be incremented if user votes again in a post' do
    log_in @user
    ratings = @post.user_ratings.count
    @post.user_ratings.push(@user.id)
    post :rate_post, id: @post.id, user_id: @user.id
    @post.reload
    assert_redirected_to :back
    assert_not_equal ratings + 2, @post.user_ratings.count
    assert_equal ratings + 1, @post.user_ratings.count
  end  

end