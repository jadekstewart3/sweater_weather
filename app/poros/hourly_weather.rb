class HourlyWeather
  attr_reader :time,
              :temperature,
              :description,
              :icon

  def initialize(weather_data)
    @time = Time.zone.at(weather_data[:time_epoch]).strftime("%H:%M")
    @temperature = weather_data[:temp_f]
    @description = weather_data[:condition][:text]
    @icon = weather_data[:condition][:icon]
  end
end