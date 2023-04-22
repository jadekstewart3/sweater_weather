class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uv_index,
              :visibility,
              :description,
              :icon

  def initialize(weather_data)
    @last_updated = weather_data[:last_updated]
    @temperature = weather_data[:temp_f]
    @feels_like = weather_data[:feelslike_f]
    @humidity = weather_data[:humidity]
    @uv_index = weather_data[:uv]
    @visibility = weather_data[:vis_miles]
    @description = weather_data[:condition][:text]
    @icon = weather_data[:condition][:icon]
  end
end