module CommentsHelper

	def new_comment(post)
		@comment = Comment.new
		@comment.post_id = post.id
	end
end