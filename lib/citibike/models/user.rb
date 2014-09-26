require_relative "bike_trip"

require_relative "../exceptions"
require_relative "../scraper"

module CitiBike
  # Models a Citi Bike user.
  class User
    ANNUAL_COST = 95.0  # dollars; current as of 9/26/14
    SECS_PER_MIN = 60.0

    attr_accessor :bike_trips
    attr_reader :username
    attr_writer :password

    def initialize(username, password = "", bike_trips = [])
      @username = username
      @password = password
      @bike_trips = bike_trips
    end

    # Downloads user's bike trips into @bike_trips
    # @param num_pages (Integer), number of Trip pages to process, optional.
    def download_trips(num_pages)
      if @password == "" # works if password is nil or empty
        raise CitiBikeError, "Downloading trip data requires a password"
      end
      scraper = Scraper.new(@username, @password)
      @bike_trips = scraper.trips(num_pages)
    end

    # Average cost per minute biking.
    def effective_cost_per_minute
      total_cost_approx * SECS_PER_MIN / total_time
    end

    # Average cost per trip.
    def effective_cost_per_trip
      total_cost_approx / @bike_trips.count
    end

    # Sum total of the duration of each trip in seconds.
    def total_time
      @bike_trips.reduce(0) { |a, e| a + (e.duration || 0) }
    end

    # Returns the approximate total cost, given Citi Bike accounts have changed
    # prices over the years.
    def total_cost_approx
      years_active = @bike_trips.reject { |t| t.end_time.nil? }
        .group_by { |t| t.end_time.year }.map { |y, _| y }
      annual_fees = years_active.map(&method(:annual_cost_for_year))
      annual_fees.reduce(0) { |a, e| a + e }
    end

    private

    def annual_cost_for_year(year)
      case
      when year <= 2014; 95.0
      when year == 2015; 149.0
      when year == 2016; 155.0
      when year == 2017; 163.0
      when year > 2017; 169.0
      end
    end
  end
end
