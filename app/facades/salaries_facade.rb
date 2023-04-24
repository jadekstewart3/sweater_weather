class SalariesFacade 
  def get_city_salaries(city)
    salaries = CityService.new.get_salaries(city)
    forecast = WeatherFacade.new.get_forecast(city)

    data = { 
          destination: city,
          salaries: salaries[:salaries],
          forecast_summary: forecast.current_weather.description,
          temperature: forecast.current_weather.temperature
        }
    Salaries.new(data)
  end
end