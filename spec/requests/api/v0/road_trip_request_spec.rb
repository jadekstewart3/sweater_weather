require "rails_helper"

RSpec.describe "RoadTrip API" do 
  describe "Create Road Trip", :vcr do
    describe "When successful" do
      it "can create a new road trip" do 

        user = User.create!(email: "fiona_hearts_cake@gmail.com", password: "password", password_confirmation: "password" )

        road_trip_params = ({origin: "Cincinatti,OH",
                            destination: "Chicago,IL",
                            api_key: user.api_key
                            })
                          
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        trip = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response).to have_http_status(200)
      
        expect(trip).to have_key(:data)
        expect(trip[:data]).to be_a(Hash)

        expect(trip[:data]).to have_key(:id)
        expect(trip[:data][:id]).to eq(nil)

        expect(trip[:data]).to have_key(:type)
        expect(trip[:data][:type]).to eq("road_trip")

        expect(trip[:data]).to have_key(:attributes)
        expect(trip[:data]).to be_a(Hash)

        expect(trip[:data][:attributes]).to have_key(:start_city)
        expect(trip[:data][:attributes][:start_city]).to be_a(String)

        expect(trip[:data][:attributes]).to have_key(:end_city)
        expect(trip[:data][:attributes][:end_city]).to be_a(String)

        expect(trip[:data][:attributes]).to have_key(:travel_time)
        expect(trip[:data][:attributes][:travel_time]).to be_a(String)

        expect(trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

        expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)

        expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

        expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
        expect(trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end

      it "returns empty weather and travel time if no route is possible" do
        user = User.create!(email: "fiona_hearts_cake@gmail.com", password: "password", password_confirmation: "password" )

        road_trip_params = ({origin: "Cincinatti,OH",
                            destination: "London, UK",
                            api_key: user.api_key
                            })
                          
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        trip = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response).to have_http_status(200)
       
        expect(trip).to have_key(:data)
        expect(trip[:data]).to be_a(Hash)

        expect(trip[:data]).to have_key(:id)
        expect(trip[:data][:id]).to eq(nil)

        expect(trip[:data]).to have_key(:type)
        expect(trip[:data][:type]).to eq("road_trip")

        expect(trip[:data]).to have_key(:attributes)
        expect(trip[:data][:attributes]).to be_a(Hash)

        expect(trip[:data][:attributes]).to have_key(:start_city)
        expect(trip[:data][:attributes][:start_city]).to be_a(String)

        expect(trip[:data][:attributes]).to have_key(:end_city)
        expect(trip[:data][:attributes][:end_city]).to be_a(String)

        expect(trip[:data][:attributes]).to have_key(:travel_time)
        expect(trip[:data][:attributes][:travel_time]).to eq("impossible")

        expect(trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(trip[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end

    describe "When unsuccessful" do
      it "returns a 401 error if the wrong api key is sent" do
        user = User.create!(email: "fiona_hearts_cake@gmail.com", password: "password", password_confirmation: "password" )

        road_trip_params = ({origin: "Cincinatti,OH",
                            destination: "Chicago,IL",
                            api_key: "UIWnaslakgiahvdnjdsa"
                            })
                          
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip_params)
     
        response_body = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to_not be_successful
        expect(response).to have_http_status(401)

        expect(response_body).to have_key(:message)
        expect(response_body[:message]).to eq("your query could not be completed")
        
        expect(response_body).to have_key(:errors)
        expect(response_body[:errors]).to be_an(Array)

        response_body[:errors].each do |error|
          expect(error).to have_key(:status)
          expect(error[:status]).to eq(401)

          expect(error).to have_key(:title)
          expect(error[:title]).to eq("Invalid credentials")
        end
      end
    end
  end
end