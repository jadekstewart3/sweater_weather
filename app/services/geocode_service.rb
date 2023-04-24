class GeocodeService
  def connection
    url = "https://www.mapquestapi.com/geocoding/v1"
    Faraday.new(url:)
  end

  def get_coordinates(location)
    response = connection.get("/geocoding/v1/address") do |req|
      req.params["location"] = location
      req.params["key"] = ENV["GEOCODE_API_KEY"]
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results][0][:locations][0][:latLng]
  end
end
