class RouteService
  def connection 
    url = "https://www.mapquestapi.com"
    Faraday.new(url: url)
  end

  def get_route(origin, destination)
    response = connection.get("/directions/v2/route") do |req|
      req.params["key"] = ENV["GEOCODE_API_KEY"]
      req.params["from"] = origin
      req.params["to"] = destination
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end