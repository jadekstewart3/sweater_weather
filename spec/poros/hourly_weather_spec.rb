require "rails_helper"

RSpec.describe HourlyWeather do 
  describe "#initialize", :vcr do 
    it "has the correct attributes" do 
      hourly_weather = WeatherFacade.new.get_forecast("denver,co").hourly_weather.first
      expect(hourly_weather.time).to eq("00:00")
      expect(hourly_weather.temperature).to eq(32.9)
      expect(hourly_weather.description).to eq("Heavy snow")
      expect(hourly_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/338.png")
    end
  end
end