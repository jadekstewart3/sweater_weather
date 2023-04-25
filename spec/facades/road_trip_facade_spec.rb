require "rails_helper"

RSpec.describe RoadTripFacade do 
  describe "#instance methods", :vcr do 
    describe "#get_trip_info" do
      before :each do 
        @trip_info = RoadTripFacade.new.get_trip_info("golden, co", "pueblo, co")
      end
      
      it "returns origin, destination, travel time, and weather upon arrival" do 
        expect(@trip_info).to be_a(RoadTrip)

        expect(@trip_info.id).to be(nil)
        expect(@trip_info.end_city).to be_a(String)
        expect(@trip_info.start_city).to be_a(String)
        expect(@trip_info.travel_time).to be_a(String)

        expect(@trip_info.weather_at_eta).to be_a(Hash)
        expect(@trip_info.weather_at_eta).to have_key(:datetime)
        expect(@trip_info.weather_at_eta[:datetime]).to be_a(String)

        expect(@trip_info.weather_at_eta).to have_key(:temperature)
        expect(@trip_info.weather_at_eta[:temperature]).to be_a(Float)

        expect(@trip_info.weather_at_eta).to have_key(:condition)
        expect(@trip_info.weather_at_eta[:condition]).to be_a(String)
      end

      it "returns an impossible trip if the trip is not possible", :vcr do 
        trip = RoadTripFacade.new.get_trip_info("golden, co", "london, uk")
        expect(trip).to be_an(ImpossibleTrip)

        expect(trip.id).to eq(nil)
        expect(trip.start_city).to be_a(String)
        expect(trip.end_city).to be_a(String)
        expect(trip.travel_time).to be_a(String)
        expect(trip.weather_at_eta).to be_a(Hash)
        expect(trip.weather_at_eta).to_not have_key(:datetime)
        expect(trip.weather_at_eta).to_not have_key(:temperature)
        expect(trip.weather_at_eta).to_not have_key(:condition)
      end
    end
  end
end