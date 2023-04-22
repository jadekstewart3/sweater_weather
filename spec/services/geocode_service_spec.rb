require "rails_helper"
RSpec.describe GeocodeService do
 describe "#instance methods" do
   describe "#get_lat_and_long" do

     let(:coordinates) { GeocodeService.new.get_coordinates("denver, co") }
     it "returns the latitude and longitude of a queried city and state" do
       expect(coordinates).to be_a(Hash)

       expect(coordinates).to have_key(:lat)
       expect(coordinates[:lat]).to be_a(Float)


       expect(coordinates).to have_key(:lng)
       expect(coordinates[:lat]).to be_a(Float)

       expect(coordinates).to_not have_key(:info)
       expect(coordinates).to_not have_key(:results)
     end
   end
 end
end
