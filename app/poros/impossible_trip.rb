class ImpossibleTrip

  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(info)
    @id = info[:id]
    @start_city = format_cities(info[:start_city])
    @end_city =  format_cities(info[:end_city])
    @travel_time = info[:travel_time]
    @weather_at_eta = info[:weather_at_eta]
  end

  private
  
  def format_cities(city)
    city.capitalize
  end
end