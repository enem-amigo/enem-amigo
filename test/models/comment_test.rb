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

	private 
	def create_comment
		@comment = Comment.create(content: 'This is a test comment')
	end
end