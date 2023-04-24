class Api::V0::ForecastsController < ApplicationController
  def show
    if params[:location].empty?
      render json: { errors: "No matches found" }, status: :bad_request
    else
      forecast = WeatherFacade.new.get_forecast(forecast_params[:location])
      render json: ForecastSerializer.new(forecast)
    end
  end

  private

  def forecast_params
    params.permit(:location)
  end
end