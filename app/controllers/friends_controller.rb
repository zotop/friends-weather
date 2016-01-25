class FriendsController < ApplicationController

	def index
		@friends = Friend.all
	end

	def edit
		@friend = Friend.find(params["id"])
	end

	def update
		@friend = Friend.find(params[:id])
	  	if @friend.update(friend_params)
	    	redirect_to friends_path
	  	else
	    	render 'edit'
	  	end
	end

	def create
		@friend = Friend.new(friend_params)
		@friend.save
  		redirect_to friends_path
	end

	def destroy 
		@friend = Friend.find(params["id"])
		@friend.destroy
		redirect_to friends_path
	end 

	private
	  def friend_params
	    params.require(:friend).permit(:firstName, :surname, :location)
	  end
end
