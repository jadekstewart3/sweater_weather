require "rails_helper"

RSpec.describe "Forecast API", :vcr do 
  describe "when successful" do 
    
    before :each do 
      get "/api/v0/forecast?location=denver, co"
      @forecast = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns a forecast for a city" do 
      expect(response).to be_successful
      expect(@forecast).to have_key(:data)
      expect(@forecast[:data]).to be_a(Hash)
      expect(@forecast[:data][:attributes]).to be_a(Hash)
    end

    it "has only the requested keys for current weather" do 
      current_weather_attributes = @forecast[:data][:attributes]
      expect(current_weather_attributes).to have_key(:current_weather)
      expect(current_weather_attributes[:current_weather]).to be_a(Hash)

      expect(current_weather_attributes[:current_weather]).to have_key(:last_updated)
      expect(current_weather_attributes[:current_weather]).to have_key(:temperature)
      expect(current_weather_attributes[:current_weather]).to have_key(:feels_like)
      expect(current_weather_attributes[:current_weather]).to have_key(:humidity)
      expect(current_weather_attributes[:current_weather]).to have_key(:uv_index)
      expect(current_weather_attributes[:current_weather]).to have_key(:visibility)
      expect(current_weather_attributes[:current_weather]).to have_key(:description)
      expect(current_weather_attributes[:current_weather]).to have_key(:icon)

      expect(current_weather_attributes[:current_weather]).to_not have_key(:last_updated_epoch)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:temp_c)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:feels_like_c)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:is_day)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:condition)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:wind_mph)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:wind_kph)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:wind_degree)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:wind_dir)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:pressure_mb)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:pressure_in)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:precip_mm)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:precip_in)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:feelslike_c)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:vis_km)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:gust_mph)
      expect(current_weather_attributes[:current_weather]).to_not have_key(:gust_kph)
    end

    it "has only the requested keys for daily weather" do 
      daily_weather_attributes = @forecast[:data][:attributes]

      expect(daily_weather_attributes).to have_key(:daily_weather)
      expect(daily_weather_attributes[:daily_weather].size).to eq(5)

      daily_weather_attributes[:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:description)
        expect(day).to have_key(:icon)

        expect(day).to_not have_key(:date_epoch)
        expect(day).to_not have_key(:day)
        expect(day).to_not have_key(:day)
        expect(day).to_not have_key(:uv)
        expect(day).to_not have_key(:astro)
        expect(day).to_not have_key(:hour)
      end
    end

    it "has only the requested keys for hourly weather" do 
      hourly_weather_attributes = @forecast[:data][:attributes]
      expect(hourly_weather_attributes).to have_key(:hourly_weather)

      hourly_weather_attributes[:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour).to have_key(:description)
        expect(hour).to have_key(:icon)
        
        expect(hour).to_not have_key(:time_epoch)
        expect(hour).to_not have_key(:temp_c)
        expect(hour).to_not have_key(:is_day)
        expect(hour).to_not have_key(:condition)
        expect(hour).to_not have_key(:wind_mph)
        expect(hour).to_not have_key(:wind_kph)
        expect(hour).to_not have_key(:wind_degree)
        expect(hour).to_not have_key(:wind_dir)
        expect(hour).to_not have_key(:pressure_mb)
        expect(hour).to_not have_key(:pressure_in)
        expect(hour).to_not have_key(:precip_mm)
        expect(hour).to_not have_key(:precip_in)
        expect(hour).to_not have_key(:humidity)
        expect(hour).to_not have_key(:cloud)
        expect(hour).to_not have_key(:feelslike_c)
        expect(hour).to_not have_key(:feelslike_f)
        expect(hour).to_not have_key(:windchill_c)
        expect(hour).to_not have_key(:windchill_f)
        expect(hour).to_not have_key(:heatindex_c)
        expect(hour).to_not have_key(:heatindex_f)
        expect(hour).to_not have_key(:dewpoint_c)
        expect(hour).to_not have_key(:dewpoint_f)
        expect(hour).to_not have_key(:will_it_rain)
        expect(hour).to_not have_key(:will_it_snow)
        expect(hour).to_not have_key(:chance_of_snow)
        expect(hour).to_not have_key(:vis_km)
        expect(hour).to_not have_key(:vis_miles)
        expect(hour).to_not have_key(:gust_mph)
        expect(hour).to_not have_key(:gust_kph)
        expect(hour).to_not have_key(:uv)
      end
    end

    describe "when unsuccessful" do 
      before :each do 
        get "/api/v0/forecast?location="
        @forecast = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 400 error if no matches are found" do 
        expect(response).to_not be_successful
        expect(response).to have_http_status(400)
        expect(@forecast).to have_key(:errors)
        expect(@forecast[:errors]).to eq("No matches found")
      end
    end
  end
end