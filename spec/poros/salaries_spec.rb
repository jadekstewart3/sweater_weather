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
      expect(@salaries.salaries).to be_an(Array)
      expect(@salaries.forecast).to be_a(Hash)
    end
  end
end