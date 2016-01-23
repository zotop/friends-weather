class WeatherController < ApplicationController
  def show
  	render json: params
  end
end
