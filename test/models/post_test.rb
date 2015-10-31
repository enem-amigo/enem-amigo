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

	private 
	def create_post
		@post = Post.create(content: 'This is a test post')
	end

end