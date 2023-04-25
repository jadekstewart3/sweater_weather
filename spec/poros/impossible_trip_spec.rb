require "rails_helper"

RSpec.describe ImpossibleTrip do 
  describe "#initialize", :vcr do 
    before :each do 
      @impossible_trip = RoadTripFacade.new.get_trip_info("golden, co", "london, uk")
    end
    it "exists" do
      expect(@impossible_trip).to be_a(ImpossibleTrip)
    end

    it "has attributes" do 
      expect(@impossible_trip.end_city).to eq("London, uk")
      expect(@impossible_trip.start_city).to eq("Golden, co")
      expect(@impossible_trip.travel_time).to eq("impossible")
      expect(@impossible_trip.weather_at_eta).to eq({})
    end
  end
end