require "rails_helper"

RSpec.describe CityService do 
  describe "#instance methods"do 
    describe "#get_salaries", :vcr do 
      it "returns salaries of a city" do
        city_salaries = CityService.new.get_salaries("albuquerque")
  
        expect(city_salaries).to be_a(Hash)
        expect(city_salaries).to have_key(:salaries)
        expect(city_salaries[:salaries]).to be_an(Array)
        
        expect(city_salaries[:salaries].first).to have_key(:job)
        expect(city_salaries[:salaries].first[:job]).to be_a(Hash)

        expect(city_salaries[:salaries].first[:job]).to have_key(:title)
        expect(city_salaries[:salaries].first[:job][:title]).to be_a(String)

        expect(city_salaries[:salaries].first).to have_key(:salary_percentiles)
        expect(city_salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)

        expect(city_salaries[:salaries].first[:salary_percentiles]).to have_key(:percentile_25)
        expect(city_salaries[:salaries].first[:salary_percentiles]).to have_key(:percentile_75)

        expect(city_salaries[:salaries].first[:salary_percentiles][:percentile_25]).to be_a(Float)
        expect(city_salaries[:salaries].first[:salary_percentiles][:percentile_75]).to be_a(Float)
      end
    end
  end
end