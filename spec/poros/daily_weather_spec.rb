require "rails_helper"

RSpec.describe DailyWeather do
  describe "#initialize", :vcr do
    it "has the correct attributes" do
      day_weather = WeatherFacade.new.get_forecast("denver, co").daily_weather.first

      expect(day_weather.date).to eq("2023-04-22")
      expect(day_weather.description).to eq("Moderate rain")
      expect(day_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/302.png")
      expect(day_weather.max_temp).to eq(43.0)
      expect(day_weather.min_temp).to eq(28.8)
      expect(day_weather.sunrise).to eq("06:12 AM")
      expect(day_weather.sunset).to eq("07:45 PM")
    end
  end
end