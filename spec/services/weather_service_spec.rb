require "rails_helper"

RSpec.describe WeatherService do 
  describe "#instance methods" do 
    describe "#forecast", :vcr do
       before :each do 
        coordinates = { lat: 39.74001, lng:-104.99202 }
        @forecast = WeatherService.new.forecast(coordinates)
       end
      it "returns the weather forecast information" do 
        expect(@forecast).to be_a(Hash)

        expect(@forecast).to have_key(:location)
        expect(@forecast[:location]).to be_a(Hash)

        expect(@forecast).to have_key(:current)
        expect(@forecast[:current]).to be_a(Hash)

        expect(@forecast).to have_key(:forecast)
        expect(@forecast[:forecast]).to be_a(Hash)

        expect(@forecast[:forecast]).to have_key(:forecastday)
        expect(@forecast[:forecast][:forecastday]).to be_an(Array)

        expect(@forecast[:forecast][:forecastday][0]).to have_key(:day)
        expect(@forecast[:forecast][:forecastday][0][:day]).to be_a(Hash)

        expect(@forecast[:forecast][:forecastday][0]).to have_key(:astro)
        expect(@forecast[:forecast][:forecastday][0][:astro]).to be_a(Hash)

        expect(@forecast[:forecast][:forecastday][0]).to have_key(:hour)
        expect(@forecast[:forecast][:forecastday][0][:hour]).to be_an(Array)
      end
    end
  end
end