class Salaries
  JOBS = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
  # DATA_ANALYST = "Data Analyst"
  # DATA_SCIENTIST = "Data Scientist"
  # MOBILE_DEVELOPER = "Mobile Developer"
  # QA_ENGINEER = "QA Engineer"
  # SOFTWARE_ENGINEER = "Software Engineer"
  # SYSTEMS_ADMINISTRATOR = "Systems Administrator"
  # WEB_DEVELOPER = "Web Developer"

  attr_reader :salaries,
              :summary,
              :temperature,
              :destination

  def initialize(data)
    @destination = data[:destination]
    @salaries = select_jobs(data[:salaries])
    @summary = data[:forecast_summary]
    @temperature = "#{data[:temperature]} F"
  end

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