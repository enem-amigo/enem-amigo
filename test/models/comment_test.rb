class CommentTest < ActiveSupport::TestCase

  test 'should be valid' do
    create_comment
    assert @comment.valid?
  end

  test 'content should not be blank' do
    create_comment
    @comment.content= ""
    assert_not @comment.valid?
  end

  test "should user_ratings be empty when comment is created" do
    create_comment
    assert @comment.user_ratings.empty?
  end

  test "should count_comment_rates returns zero when comment is created" do
    create_comment
    assert_equal @comment.count_comment_rates, 0
  end

  private
  def create_comment
    @comment = Comment.create(content: 'This is a test comment')
  end
end