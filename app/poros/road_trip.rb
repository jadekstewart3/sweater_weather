class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(route, forecast)
    require 'pry'; binding.pry
    @id = nil
    @start_city = "#{route[:route][:locations][0][:adminArea5]}, #{route[:route][:locations][0][:adminArea5]}"
    @end_city = "#{route[:route][:locations][-1][:adminArea5]}, #{route[:route][:locations][-1][:adminArea5]}"
    @travel_time = route[:route][:formattedTime]
    @weather_at_eta = weather_at_eta(forecast, route[:route][:realTime])
  end

  def weather_at_eta(forecast, travel_time)
    arrival_time = Time.now + travel_time

    forecast[:forecast][:forecastday][:hour].each do |weather|
      require 'pry'; binding.pry
      if arrival_time.between(Time.at(weather[:time]).to_i, (Time.at(weather[:time]) + 3600))
        return {
                temperature: weather.temperature,
                condition: weather.description
              }
      end
    end
  end

#Time.parse to convert date_time@
end