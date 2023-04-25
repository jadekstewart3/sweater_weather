require "rails_helper"

RSpec.describe RoadTripFacade do 
  describe "#instance methods", :vcr do 
    describe "#get_trip_info" do
      before :each do 
        @trip_info = RoadTripFacade.new.get_trip_info("golden, co", "pueblo, co")
      end
      it "returns origin, destination, travel time, and weather upon arrival" do 
        expect(@trip_info).to be_a(RoadTrip)
      end
    end
  end
end