require "rails_helper"

RSpec.describe WeatherService do 
  describe "#instance methods" do 
    describe "#forecast" do 
      it "returns the weather forecast information" do 
        coordinates = { lat: 39.74001, lng:-104.99202 }

        forecast = WeatherService.new.forecast(coordinates)
require 'pry'; binding.pry
        expect(forecast).to be_a(Hash)
      end
    end
  end
end