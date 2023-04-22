class WeatherFacade

  def get_forecast(location)
    coordinates = GeocodeService.new.get_coordinates(location)
    forecast = WeatherService.new.forecast(coordinates)
    weather_hash =  { current_weather: CurrentWeather.new(forecast[:current]),
                      daily_weather: forecast[:forecast][:forecastday][0..4].map { |day| DailyWeather.new(day) },
                      hourly_weather: forecast[:forecast][:forecastday][0][:hour].map { |hour| HourlyWeather.new(hour) }
                    }
    Forecast.new(weather_hash)
  end
end