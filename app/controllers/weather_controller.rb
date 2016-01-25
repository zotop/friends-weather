
class WeatherController < ApplicationController
   
  WEATHER_API_KEY = '32a40352b94f9f112f73bc2f2cd13765'
  WEATHER_BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

  def show
  	friends = Friend.find params['friends_id']
  	@friendsWeather = Array.new 
  	hydra = Typhoeus::Hydra.new
  	friends.each do |friend|
  		location = CGI.escape friend['location']
		weatherApiUrl = WEATHER_BASE_URL + "?q=" + location + "&appid=" + WEATHER_API_KEY + "&units=metric"
  		request = Typhoeus::Request.new weatherApiUrl
    	request.on_complete do |response|
    		jsonResponse = JSON.parse response.body
      		temperature = jsonResponse['main']['temp']
			weatherDescription = jsonResponse['weather'][0]['description'].downcase
			weatherIcon = jsonResponse['weather'][0]['icon']
			friendAsHash = friend.attributes
			friendAsHash ['temperature'] = temperature
			friendAsHash ['weatherDescription'] = weatherDescription
			friendAsHash ['weatherIcon'] = weatherIcon
			@friendsWeather.push friendAsHash	
    	end

  		hydra.queue request
  	end
  	hydra.run
   	 

  end

end
