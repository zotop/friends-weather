class FriendsController < ApplicationController


	def index
		@friends = Friend.all
	end

	def create
		@friend = Friend.new(friend_params)
		@friend.save
  		redirect_to friends_path
	end

	private
	  def friend_params
	    params.require(:friend).permit(:firstName, :surname, :location)
	  end
end
