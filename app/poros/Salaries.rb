class Salaries
  JOBS = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]

  attr_reader :id,
              :salaries,
              :destination,
              :forecast

  def initialize(data)
    @id = nil
    @destination = data[:destination]
    @salaries = select_jobs(data[:salaries])
    @forecast = { "summary" => data[:forecast_summary], "temperature" => "#{data[:temperature].round} F",}
  end

  private

  def select_jobs(jobs_array)
    jobs_array.map do |job|
      if JOBS.include?(job[:job][:title])
        {
          "title" => job[:job][:title],
          "min" => "$#{job[:salary_percentiles][:percentile_25].round(2)}",
          "max" => "$#{job[:salary_percentiles][:percentile_75].round(2)}",
        }
      else
        next
      end
    end.compact
  end
end