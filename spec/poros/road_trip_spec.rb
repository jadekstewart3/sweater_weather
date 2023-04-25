require "rails_helper"

RSpec.describe RoadTrip do 
  describe "#initialize", :vcr do 
    before :each do 
      @trip = RoadTripFacade.new.get_trip_info("denver, co", "panama city, panama")
    end
    it "exists" do 
      expect(@trip).to be_a(RoadTrip)
    end

    it "has attributes" do 
      expect(@trip.id).to eq(nil)
      expect(@trip.start_city).to eq("Denver, CO")
      expect(@trip.end_city).to eq("Ciudad de Panamá, PA-8")
      expect(@trip.travel_time).to eq("68:17:17")
      expect(@trip.weather_at_eta).to be_a(Hash)
      expect(@trip.weather_at_eta[:datetime]).to eq("2023-04-28 10:00")
      expect(@trip.weather_at_eta[:temperature]).to eq(88.9)
      expect(@trip.weather_at_eta[:condition]).to eq("Sunny")
    end
  end
end