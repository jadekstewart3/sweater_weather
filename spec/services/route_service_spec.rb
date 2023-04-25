require "rails_helper"

RSpec.describe RouteService do 
  describe "#instance methods", :vcr do
    describe "#get_route" do
      it "returns the route from an origin to a destination" do
        route = RouteService.new.get_route("golden, co", "rye, co")

        expect(route).to be_a(Hash)
        expect(route).to have_key(:route)
        expect(route[:route]).to be_a(Hash)

        expect(route[:route]).to have_key(:formattedTime)
        expect(route[:route][:formattedTime]).to be_a(String)
      end
    end
  end
end