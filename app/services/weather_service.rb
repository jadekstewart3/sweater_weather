class WeatherService
  def connection
    url = "https://api.weatherapi.com/v1/"
    Faraday.new(url)
  end

  def forecast(coordinates)
    response = connection.get("forecast.json") do |req|
      req.headers["Content-Type"] = "application/json"
      req.params["key"] = ENV["WEATHER_API_KEY"]
      req.params["q"] = "#{coordinates[:lat]},#{coordinates[:lng]}"
      req.params["days"] = 5
      req.params["tp"] = 60
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end