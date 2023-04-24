require "rails_helper"

RSpec.describe "Salaries API", :vcr do 
  describe "when successful" do 
    before :each do 
      get "/api/v0/salaries?destination=albuquerque"
      @salaries_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns the weather and the salaries for that city" do 
      expect(response).to be_successful
      expect(@salaries_response).to have_key(:data)
      expect(@salaries_response[:data]).to be_a(Hash)
      expect(@salaries_response[:data]).to have_key(:attributes)
      expect(@salaries_response[:data][:attributes]).to be_a(Hash)
    end

    it "has the correct keys and data types" do 
      salaries_json = @salaries_response[:data][:attributes]

      expect(salaries_json).to have_key(:destination)
      expect(salaries_json[:destination]).to be_a(String)

      expect(salaries_json).to have_key(:forecast)
      expect(salaries_json[:forecast]).to be_a(Hash)

      expect(salaries_json[:forecast]).to have_key(:summary)
      expect(salaries_json[:forecast][:summary]).to be_a(String)

      expect(salaries_json[:forecast]).to have_key(:temperature)
      expect(salaries_json[:forecast][:temperature]).to be_a(String)

      expect(salaries_json).to have_key(:salaries)
      expect(salaries_json[:salaries]).to be_an(Array)

      salaries_json[:salaries].each do |job|
        expect(job).to have_key(:title)
        expect(job[:title]).to be_a(String)

        expect(job).to have_key(:min)
        expect(job[:min]).to be_a(String)

        expect(job).to have_key(:max)
        expect(job[:max]).to be_a(String)
      end
    end
  end
  
  describe "when unsuccessful" do 
    before :each do
      get "/api/v0/salaries?destination="
      @salaries = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns a 400 error if no matches are found" do 
      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      expect(@salaries).to have_key(:errors)
      expect(@salaries[:errors]).to eq("No matches found")
    end
  end
end
