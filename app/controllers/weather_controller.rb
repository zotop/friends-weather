class WeatherController < ApplicationController
  def show
  	render plain: params
  end
end
