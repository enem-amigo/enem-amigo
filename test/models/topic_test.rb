class TopicTest < ActiveSupport::TestCase

	test 'should be valid'  do
		create_topic
		assert @topic.valid?	
	end

	test 'name should not be blank' do
		create_topic
		@topic.name=""
		assert_not @topic.valid?
	end

	test 'description should not be blank' do
		create_topic
		@topic.description=""
		assert_not @topic.valid?
	end

	private
	def create_topic
		@topic = Topic.create(name: 'Test Topic', description: 'This is a test topic')
	end
end