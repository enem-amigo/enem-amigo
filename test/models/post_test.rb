class PostTest < ActiveSupport::TestCase

  test 'should be valid' do
    create_post
    assert @post.valid?
  end

  test 'content should not be blank' do
    create_post
    @post.content= ""
    assert_not @post.valid?
  end

  test "should user_ratings be empty when post is created" do
    create_post
    assert @post.user_ratings.empty?
  end

  test "should count_post_rates returns zero when post is created" do
    create_post
    assert_equal @post.count_post_rates, 0
  end

  private
  def create_post
    @post = Post.create(content: 'This is a test post')
  end

end