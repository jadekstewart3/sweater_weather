class Api::V0::ForecastController < ApplicationController
  def show
    unless params[:location].empty?
      forecast = WeatherFacade.new.get_forecast(forecast_params[:location])
      render json: ForecastSerializer.new(forecast)
    else
      render json: { errors: "No matches found" }, status: 400
    end
  end

  private
  def forecast_params
    params.permit(:location)
  end
end