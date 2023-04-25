class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      road_trip = RoadTripFacade.new.get_trip_info(road_trip_params[:origin], road_trip_params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: ErrorSerializer.failed_auth, status: 401
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

end