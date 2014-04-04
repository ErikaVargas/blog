class CommentsController < ApplicationController
	skip_before_filter :verify_autenticity_token

	def create
		@post=Post.find(params[:post_id]) 
		@post.comments.create(comments_params) 

		redirect_to @post 
	end

	private
		def comments_params
			params.require(:comment).permit(:body)
		end
	


end
