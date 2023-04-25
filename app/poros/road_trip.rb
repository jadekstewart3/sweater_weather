class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(route, forecast)
    @id = nil
    @start_city = "#{route[:route][:locations][0][:adminArea5]}, #{route[:route][:locations][0][:adminArea3]}"
    @end_city = "#{route[:route][:locations][-1][:adminArea5]}, #{route[:route][:locations][-1][:adminArea3]}"
    @travel_time = route[:route][:formattedTime]
    @weather_at_eta = weather_at_destination(forecast, route[:route][:realTime])
  end

  private

  def weather_at_destination(forecast, travel_time)
    arrival_time = Time.now + travel_time

    forecast[:forecast][:forecastday].each do |day|
      if arrival_time.to_s.include?(day[:date])
        day[:hour].each do |hour|
          if arrival_time.between?(Time.parse(hour[:time]), (Time.parse(hour[:time]) + 1.hour))
            return {
                    datetime: hour[:time],
                    temperature: hour[:temp_f],
                    condition: hour[:condition][:text]
                  }
          end
        end
      end
    end
  end
end