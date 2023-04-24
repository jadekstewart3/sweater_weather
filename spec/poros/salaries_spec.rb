require "rails_helper"

RSpec.describe Salaries do 
  describe "#initialize", :vcr do 
    before :each do 
      @salaries = SalariesFacade.new.get_city_salaries("denver")
    end

    it "exists" do 
      expect(@salaries).to be_a(Salaries)
    end

    it "has attributes" do 
      expect(@salaries.id).to eq(nil)
      expect(@salaries.destination).to eq("denver")

      expect(@salaries.forecast).to be_a(Hash)  
      expect(@salaries.forecast).to have_key("summary")
      expect(@salaries.forecast["summary"]).to be_a(String)
      
      expect(@salaries.forecast).to have_key("temperature")
      expect(@salaries.forecast["temperature"]).to be_a(String)
      
      expect(@salaries.salaries).to be_an(Array)
      @salaries.salaries.each do |job|
        expect(job).to have_key("title")
        expect(job["title"]).to be_a(String)
        expect(job).to have_key("min")
        expect(job["min"]).to be_a(String)
        expect(job).to have_key("max")
        expect(job["max"]).to be_a(String)
      end

      
    end
  end
end