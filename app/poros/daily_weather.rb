class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :description,
              :icon

  def initialize(weather_data)
    @date = weather_data[:date]
    @sunrise = weather_data[:astro][:sunrise]
    @sunset = weather_data[:astro][:sunset]
    @max_temp = weather_data[:day][:maxtemp_f]
    @min_temp = weather_data[:day][:mintemp_f]
    @description = weather_data[:day][:condition][:text]
    @icon = weather_data[:day][:condition][:icon]
  end
end