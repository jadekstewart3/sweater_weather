require "rails_helper"

RSpec.describe CurrentWeather do
  describe "#initialize", :vcr do
    it "has the correct attributes" do
      current_weather = WeatherFacade.new.get_forecast("denver, co").current_weather
      expect(current_weather.last_updated).to eq("2023-04-22 16:30")
      expect(current_weather.temperature).to eq(33.1)
      expect(current_weather.feels_like).to eq(28.6)
      expect(current_weather.humidity).to eq(66)
      expect(current_weather.uv_index).to eq(3.0)
      expect(current_weather.visibility).to eq(9.0)
      expect(current_weather.description).to eq("Overcast")
      expect(current_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/122.png")
    end
  end
end