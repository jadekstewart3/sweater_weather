class CityService
  def connection 
    url = "https://api.teleport.org/api/"
    Faraday.new(url: url)
  end

  def get_salaries(city)
    response = connection.get("urban_areas/slug:#{city}/salaries")
    JSON.parse(response.body, symbolize_names: true)
  end
end