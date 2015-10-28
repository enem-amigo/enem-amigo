module CommentsHelper

	def new_comment(post)
		@comment = Comment.new
		session[:post_id] = post.id
	end
	
end