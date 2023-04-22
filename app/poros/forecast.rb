class Forecast 
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(weather_hash)
    @id = nil
    @current_weather = weather_hash[:current_weather]
    @daily_weather = weather_hash[:daily_weather]
    @hourly_weather = weather_hash[:hourly_weather]
  end
end