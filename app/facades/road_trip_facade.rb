class RoadTripFacade
  
  def get_trip_info(origin, destination)
    route_data = RouteService.new.get_route(origin, destination)
    coordinates = GeocodeService.new.get_coordinates(destination)
    forecast = WeatherService.new.forecast(coordinates)
    RoadTrip.new(route_data, forecast)
  end

  
end