require "rails_helper"

RSpec.describe "SalariesFacade" do 
  describe "#instance methods", :vcr do 
    describe  "#get_city_salaries" do 
      before :each do 
        @salaries = SalariesFacade.new.get_city_salaries("albuquerque")
      end
      it "returns a sample of city salaries and weather in a salary poro" do 
        expect(@salaries).to be_a(Salaries)
        expect(@salaries.destination).to eq("albuquerque")
      
       expect(@salaries.forecast).to be_a(Hash)
       expect(@salaries.forecast).to have_key("summary")
       
       expect(@salaries.forecast["summary"]).to eq("Partly cloudy")
       expect(@salaries.forecast["temperature"]).to eq("55.0 F")

        expect(@salaries.salaries.first).to have_key("title")
        expect(@salaries.salaries.first["title"]).to eq("Data Analyst")

        expect(@salaries.salaries.first).to have_key("min")
        expect(@salaries.salaries.first["min"]).to eq("$33498.7")

        expect(@salaries.salaries.first).to have_key("max")
        expect(@salaries.salaries.first["max"]).to eq("$48520.85")
      end
    end
  end
end