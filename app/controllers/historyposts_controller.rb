class HistorypostsController < ApplicationController
skip_before_filter :verify_autenticity_token
	def create 
		@post.historypost.create(history_params) 
		redirect_to @post 
	end

	private
		def history_params
			params.require(:historypost).permit(:title, :text)
		end

end
