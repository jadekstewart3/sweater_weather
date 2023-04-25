class RoadTripFacade
  def get_trip_info(origin, destination)
    route_data = RouteService.new.get_route(origin, destination)

    if route_data[:info][:statuscode] == 0
      coordinates = GeocodeService.new.get_coordinates(destination)
      forecast = WeatherService.new.forecast(coordinates)
      RoadTrip.new(route_data, forecast)
    else
      impossible_route_data = {
                    id: nil,
                    start_city: origin,
                    end_city: destination,
                    travel_time: "impossible",
                    weather_at_eta: {}
                  }
      ImpossibleTrip.new(impossible_route_data)
    end
  end
end