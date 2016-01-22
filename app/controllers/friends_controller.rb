class FriendsController < ApplicationController


	def index
		@friends = Friend.all
	end

	def create
		@friend = Friend.new(friend_params)
		@friend.save
  		redirect_to friends_path
	end

	def weather
		redirect_to controller: 'weather', action: 'show', friends_id: params['friends_id']
	end

	private
	  def friend_params
	    params.require(:friend).permit(:firstName, :surname, :location)
	  end
end
