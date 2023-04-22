require "rails_helper"

RSpec.describe Forecast do 
  describe "#initialize", :vcr do
    before :each do 
      @forecast = WeatherFacade.new.get_forecast("denver, co")
    end
    it "exists" do
      expect(@forecast).to be_a(Forecast)
    end

    it "has attributes" do 
      expect(@forecast.id).to eq(nil)
      expect(@forecast.current_weather).to be_a(CurrentWeather)
      expect(@forecast.daily_weather).to be_an(Array)
      expect(@forecast.hourly_weather).to be_an(Array)
    end
  end
end