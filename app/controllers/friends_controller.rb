require 'open-uri'

WEATHER_API_KEY = '32a40352b94f9f112f73bc2f2cd13765'
WEATHER_BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

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
		#http://api.openweathermap.org/data/2.5/weather?q=Barreiro&appid=44db6a862fba0b067b1930da0d769e98&units=metric
		@friends = Friend.find params['friends_id']
		result = Array.new 
		for index in 0 ... @friends.size
  			location = @friends.at(index)['location']
  			weatherApiUrl = WEATHER_BASE_URL + "?q=" + location + "&appid=" + WEATHER_API_KEY + "&units=metric"
			response = open(weatherApiUrl).read
			temperature = JSON.parse(response)['main']['temp']
			weatherDescription = JSON.parse(response)['weather'][0]['description']
			weatherIcon = JSON.parse(response)['weather'][0]['icon']
			friendAsHash = @friends.at(index).attributes
			friendAsHash ['temperature'] = temperature
			friendAsHash ['weatherDescription'] = weatherDescription
			friendAsHash ['weatherIcon'] = weatherIcon
			result.push friendAsHash
		end
		 
		render json: result

		 
		
		
	
		 
		
		#redirect_to controller: 'weather', action: 'show', friends_id: params['friends_id']
	end

	private
	  def friend_params
	    params.require(:friend).permit(:firstName, :surname, :location)
	  end
end
