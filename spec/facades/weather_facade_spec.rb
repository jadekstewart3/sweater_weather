require "rails_helper"

RSpec.describe WeatherFacade do 
  describe "#instance_methods" do 
    describe "#get_forecast", :vcr do 
      before :each do 
        @forecast = WeatherFacade.new.get_forecast("denver, co")
      end
      it "returns a hash with all of the forecast details do" do
        expect(@forecast).to be_a(Forecast)
        expect(@forecast.current_weather).to be_a(CurrentWeather)
        expect(@forecast.daily_weather.first).to be_a(DailyWeather)
        expect(@forecast.hourly_weather.first).to be_a(HourlyWeather)
      end

      it "current weather contains desired attributes" do 
        current_weather = @forecast.current_weather

        expect(current_weather.last_updated).to be_a(String)
        expect(current_weather.temperature).to be_a(Float)
        expect(current_weather.feels_like).to be_a(Float)
        expect(current_weather.humidity).to be_a(Float).or be_an(Integer)
        expect(current_weather.uv_index).to be_a(Float).or be_an(Integer)
        expect(current_weather.visibility).to be_a(Float).or be_an(Integer)
        expect(current_weather.description).to be_a(String)
        expect(current_weather.icon).to be_a(String)
      end

      it "daily weather contains desired attributes" do 
        daily_weather = @forecast.daily_weather

        daily_weather.each do |day|
          expect(day.date).to be_a(String)
          expect(day.sunrise).to be_a(String)
          expect(day.sunset).to be_a(String)
          expect(day.max_temp).to be_a(Float)
          expect(day.min_temp).to be_a(Float)
          expect(day.description).to be_a(String)
          expect(day.icon).to be_a(String)
        end
      end

      it "hourly weather contains desired attributes" do 
        hourly_weather = @forecast.hourly_weather

        hourly_weather.each do |hour|
          expect(hour.time).to be_a(String)
          expect(hour.temperature).to be_a(Float)
          expect(hour.description).to be_a(String)
          expect(hour.icon).to be_a(String)
        end
      end
    end
  end
end